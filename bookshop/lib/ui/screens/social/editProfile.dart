/*import 'package:E_Soor/ui/screens/social/profile.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final name;
  final bio;
  EditPage(this.name, this.bio);
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var _name = '';
  var _bio = '';

  void alertDialog(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(
        'Discard',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      content: Text(
        'Discard changes?',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      actions: [
        FlatButton(
          child: Text(
            'Yes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () {},
        ),
        FlatButton(
          child: Text(
            'No',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  void alertDialog2(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text('Save',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      content: Text('Save Changes?',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      backgroundColor: Colors.redAccent,
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Yes',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onPressed: () {
            var route = MaterialPageRoute(
              builder: (BuildContext context) =>
                  new ProfilePage(),
              
            );

            Navigator.of(context).push(route);
          },
        ),
        FlatButton(
            child: Text('No',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void bottomsheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              decoration: BoxDecoration(color: Color(0xFF737373)),
              child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.camera_alt, color: Colors.white),
                        title: Text('Take New Photo',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.photo, color: Colors.white),
                        title: Text('Choose From Gallery',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onTap: () {},
                      ),
                    ],
                  )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  alertDialog(context);
                },
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('save changes',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  color: Colors.black,
                  onPressed: () {
                    alertDialog2(context);
                  },
                )
              ],
            ),
            body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Stack(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/images/omar.jpg'),
                            radius: 50,
                          ),
                        ],
                      ),
                      onTap: () {
                        bottomsheet(context);
                      },
                    ),
                    SizedBox(height: 20),
                    Card(
                        margin: EdgeInsets.all(10),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  _name = val;
                                });
                              },
                              initialValue: widget.name,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  labelText: 'Edit Profile Name',
                                  icon: Icon(Icons.mode_edit,
                                      color: Colors.black)),
                            ))),
                    SizedBox(height: 20),
                    Card(
                        margin: EdgeInsets.all(10),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                            child: TextFormField(
                              initialValue: widget.bio,
                              cursorColor: Colors.black,
                              onChanged: (val) {
                                setState(() {
                                  _bio = val;
                                });
                              },
                              decoration: InputDecoration(
                                  labelText: 'Edit Your Bio',
                                  icon: Icon(
                                    Icons.book,
                                    color: Colors.black,
                                  )),
                            ))),
                  ],
                ))));
  }
}*/
