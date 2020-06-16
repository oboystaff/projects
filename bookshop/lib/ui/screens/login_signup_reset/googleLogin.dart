import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginPage extends StatefulWidget {
  GoogleLoginPage({Key key}) : super(key: key);

  @override
  _GoogleLoginPageState createState() => _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<GoogleLoginPage> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  bool isAuth = false;

  // @override
  // void initState() {
  //   super.initState();
  //   googleSignIn.onCurrentUserChanged.listen((account) {
  //     if (account != null) {
  //       print("User Acount is :- $account");
  //       setState(() {
  //         isAuth = true;
  //       });
  //     } else {
  //       setState(() {
  //         isAuth = false;
  //       });
  //     }
  //   });
  // }

  login() {
    googleSignIn.signIn();
  }

  Widget buildAuthScreen() {
    return RaisedButton(
      child: Text("Sign In with Google"),
      onPressed: login(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildAuthScreen();
  }
}
