import 'package:E_Soor/services/firebase.auth.dart';
import 'package:E_Soor/ui/screens/login_signup_reset/emailLogin.dart';
import 'package:E_Soor/ui/widgets/actionsButton.dart';
import 'package:E_Soor/ui/widgets/userCard.dart';
import 'package:E_Soor/ui/screens/other/about_us.dart';
import 'package:E_Soor/ui/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:E_Soor/ui/screens/store/bookMarks.dart';

class MyDrawer extends StatelessWidget {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    void goToSettings() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Settings(),
        ),
      );
    }

    void goToAboutUs() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AboutUs(),
        ),
      );
    }

    return Container(
      color: Theme.of(context).primaryColor,
      height: double.infinity,
      width: screenWidth - (screenWidth * 0.23),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              UserCard(),
              ActionsButton(),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text("Book Marks"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookMarks(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: goToSettings,
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About us"),
                onTap: goToAboutUs,
              ),
              ListTile(
                leading: Icon(Icons.backspace),
                title: Text("Log out"),
                onTap: () {
                  _firebaseAuthService.logOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
