import 'package:flutter/material.dart';

class FaceBookLoginPage extends StatefulWidget {
  FaceBookLoginPage({Key key}) : super(key: key);

  @override
  _FaceBookLoginPageState createState() => _FaceBookLoginPageState();
}

class _FaceBookLoginPageState extends State<FaceBookLoginPage> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fb.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      onPressed: () {},
    );
  }
}
