import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///package that offers custom icons.
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

///package that launches URLs.
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  ///function that launches URLs by pressing on a button
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command, forceWebView: true);
    } else {
      print(" could not launch $command");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About us"),
        centerTitle: true,
      ),
      body: ListView(shrinkWrap: true, children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              ///app logo.
              CircleAvatar(
                maxRadius: 100,
                backgroundImage: ExactAssetImage("assets/images/logo.png"),
              ),
              SizedBox(height: 20),

              ///app name.
              Text(
                "E-SOOR",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(15),

                /// app description text.
                child: Text(
                  "This is a book store and a social network platform that aims to group readers of all ages from all around the world and offer them a great experince.",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),

              ///the social media icon buttons row.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(MdiIcons.instagram, size: 40),
                    onPressed: () {
                      customLaunch("https://www.facebook.com/esoorapp/");
                    },
                  ),
                  IconButton(
                    icon: Icon(MdiIcons.twitter, size: 40),
                    onPressed: () {
                      customLaunch("https://www.facebook.com/esoorapp/");

                      ///calling customLaunch() to launch urls adressed to the icon buttons///
                    },
                  ),
                  IconButton(
                    icon: Icon(MdiIcons.facebook, size: 40),
                    onPressed: () {
                      customLaunch("https://www.facebook.com/esoorapp/");
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),

              ///button to launch E-soors website url.
              FlatButton(
                color: Colors.grey[700],
                child: Text('Visit Our website'),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                onPressed: () {},
              )
            ],
          ),
        )
      ]),
    );
  }
}
