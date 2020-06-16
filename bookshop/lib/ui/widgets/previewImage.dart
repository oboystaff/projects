import 'package:flutter/material.dart';

class PreviewImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
