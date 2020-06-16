import 'package:E_Soor/helpers/sharedPrefs.dart';
import 'package:E_Soor/ui/screens/login_signup_reset/emailLogin.dart';
import 'package:E_Soor/main.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  final SharedPrefsUtils _sharedPrefs = SharedPrefsUtils.getInstance();
  Future<bool> isLoggedIn;
  Future<bool> get isUserLoggedIn {
    bool value = _sharedPrefs.getData("isUserLoggedIn");
    if (value == null) {
      return Future.value(false);
    }
    return Future.value(value);
  }

  @override
  void initState() {
    // isLoggedIn = Provider.of<FirebaseAuthService>(context).isUserLoggedIn;
    isLoggedIn = isUserLoggedIn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _userAuthProvider = Provider.of<FirebaseAuthService>(context);
    return SafeArea(
      child: SplashScreen(
        photoSize: 200,
        backgroundColor: Color.fromRGBO(35, 35, 35, 100),
        seconds: 2,
        navigateAfterSeconds: FutureBuilder<bool>(
          future: isLoggedIn,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.data) {
              return LoginPage();
            }
            return MyHomePage();
          },
        ),
        image: Image.asset("assets/images/logo.png"),
        loaderColor: Colors.white,
        loadingText: Text(
          "Loading",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
