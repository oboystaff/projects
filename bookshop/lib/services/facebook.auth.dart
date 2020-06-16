import 'package:E_Soor/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin _facebookLogin = FacebookLogin();
  final Firestore _firestore = Firestore.instance;
  final String _usersCollectionData = "users";
  bool _isNewUser;
  bool get isNewUser => _isNewUser;

  Future<void> _registerUserOnFirebase(AuthResult authResult) async {
    final FirebaseUser firebaseAuthCredentialUser = authResult.user;
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    if (firebaseAuthCredentialUser.uid != currentUser.uid) {
      throw PlatformException(
          code: 'ERROR_GOOGLE_AUTH_USER_MISMATCH',
          message:
              "Google auth user doesn't match the current logged Firebse user");
    } else {
      _createUserData(userEmail: currentUser.email, authResultUser: authResult);
    }
  }

  //* Adding user initail/Important data on Firestore
  Future<void> _createUserData(
      {String userEmail, AuthResult authResultUser}) async {
    _isNewUser = authResultUser.additionalUserInfo.isNewUser;
    if (!authResultUser.additionalUserInfo.isNewUser) {
      return;
    }
    final DateTime creationTime = DateTime.now();
    try {
      String userID = (await _firebaseAuth.currentUser()).uid;
      var userDoc =
          _firestore.collection(_usersCollectionData).document(userID);
      await userDoc.setData(
        User(
          uid: userID,
          emailAddress: userEmail,
          creationTime: creationTime,
          lastInfoUpdate: creationTime,
          displayName: authResultUser.user.displayName,
        ).toJson(),
      );
    } on PlatformException catch (uploadUserInitialDataError) {
      throw PlatformException(
          code: 'ERROR_WHILE_SAVING_USER_DATA',
          message: 'check the user data entered by the user');
    }
  }

  /// **Important**: You must enable the relevant accounts in the Auth section
  /// of the Firebase console before being able to use them.
  ///
  /// Errors:
  ///   • `ERROR_INVALID_CREDENTIAL` - If the credential data is malformed or has expired.
  ///   • `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
  ///   • `ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL` - If there already exists an account with the email address asserted by Google.
  ///       Resolve this case by calling [fetchSignInMethodsForEmail] and then asking the user to sign in using one of them.
  ///       This error will only be thrown if the "One account per email address" setting is enabled in the Firebase console (recommended).
  ///   • `ERROR_OPERATION_NOT_ALLOWED` - Indicates that Google accounts are not enabled.
  ///   • `ERROR_INVALID_ACTION_CODE` - If the action code in the link is malformed, expired, or has already been used.
  ///       This can only occur when using [EmailAuthProvider.getCredentialWithLink] to obtain the credential.
  Future<void> signInWithFacebook() async {
    try {
      // https://github.com/roughike/flutter_facebook_login/issues/210
      _facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
      final FacebookLoginResult result =
          await _facebookLogin.logIn(<String>['email', 'public_profile']);
      if (result.accessToken != null) {
        final AuthResult authResult = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token,
          ),
        );
        await _registerUserOnFirebase(authResult);
      } else {
        throw PlatformException(
            code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await _facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
