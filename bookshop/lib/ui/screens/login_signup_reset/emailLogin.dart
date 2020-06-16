import 'package:E_Soor/main.dart';
import 'package:E_Soor/services/firebase.auth.dart';
import 'package:E_Soor/services/signIn.validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';

class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 1800);
  final SignInValidator _signInValidator = SignInValidator();

  @override
  Widget build(BuildContext context) {
    final _firebaseAuthService = Provider.of<FirebaseAuthService>(context);
    return Response(
        originalScreenHeight: MediaQuery.of(context).size.height * 1,
        originalScreenWidth: MediaQuery.of(context).size.width * 1,
        child: FlutterLogin(
          logo: 'assets/images/logo.png',
          onLogin: _firebaseAuthService.loginUser,
          onSignup: _firebaseAuthService.registerNewUser,
          onRecoverPassword: _firebaseAuthService.recoverPassword,
          emailValidator: _signInValidator
              .emailValidator, //_signInValidator.emailValidator,
          passwordValidator: _signInValidator.passwordValidator,
          onSubmitAnimationCompleted: () {
            //! needs to be change to a 'Named Route'
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyHomePage()));
          },
          theme: LoginTheme(
            errorColor: Colors.green,
            primaryColor: Color.fromRGBO(35, 35, 35, 100),
            accentColor: Colors.white,
            buttonTheme: LoginButtonTheme(
              splashColor: Colors.green,
              backgroundColor: Colors.grey,
            ),
            textFieldStyle: TextStyle(
              color: Colors.white,
            ),
            inputTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.black87,
              contentPadding: EdgeInsets.zero,
              errorStyle: TextStyle(
                backgroundColor: Colors.red.withOpacity(.7),
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(100),
              ),
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
