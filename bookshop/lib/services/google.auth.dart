import 'package:E_Soor/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

//! [Solved] Error Handling Docs weren't finished, yet
//! [solved] saving auth data to firebase store

class GoogleAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Firestore _firestore = Firestore.instance;
  final String _usersCollectionData = "users";
  bool _isNewUser;
  bool get isNewUser => _isNewUser;

  Future<GoogleSignInAuthentication> _getGoogleSignInAuthAccount(
      GoogleSignInAccount googleSignInAccount) async {
    final GoogleSignInAuthentication googleSignInAuth =
        await googleSignInAccount.authentication;
    if (googleSignInAuth != null && googleSignInAuth != null) {
      return googleSignInAuth;
    } else {
      throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token');
    }
  }

  Future<AuthResult> _getAuthResult(
      GoogleSignInAuthentication googleSignInAuth) async {
    try {
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );
      final AuthResult authResult =
          await _firebaseAuth.signInWithCredential(credential);

      return authResult;
    } on PlatformException catch (signInWithCredentialFirebaseError) {
      throw PlatformException(
        code: signInWithCredentialFirebaseError.code,
        message: signInWithCredentialFirebaseError.message,
      );
    }
  }

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

  //? [SOLVED]: can return PlatformException (sign_in_failed) {not in docs}
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication _googleSignInAccount =
          await _getGoogleSignInAuthAccount(googleSignInAccount);
      final AuthResult _authResult = await _getAuthResult(_googleSignInAccount);
      await _registerUserOnFirebase(_authResult);
      return;
    }
    throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
