import 'package:E_Soor/services/firebase.auth.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  String _picUrl = "";
  String _userName = "";
  String _userEmail = "";
  final FirebaseAuthService _auth = FirebaseAuthService();

  _UserCardState() {
    _auth.getCurrentUserProfilePic().then(
          (value) => setState(
            () {
              _picUrl = value;
            },
          ),
        );
    _auth.getCurrentUserName().then(
          (value) => setState(
            () {
              _userName = value;
            },
          ),
        );
    _auth.getCurrentUserEmail().then(
          (value) => setState(
            () {
              _userEmail = value;
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.725;

    double screenAspectRatio = MediaQuery.of(context).size.aspectRatio;

    return SizedBox(
      height: cardWidth * screenAspectRatio + (screenHeight * 0.2),
      width: cardWidth,
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      "https://placekitten.com/400/400",
                      // _picUrl,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                _userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: AutoSizeText(
                _userEmail,
                maxLines: 1,
                stepGranularity: 1,
                minFontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
