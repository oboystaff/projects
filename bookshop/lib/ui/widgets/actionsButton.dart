import 'package:flutter/material.dart';
import 'package:E_Soor/ui/screens/store/addNewBook.dart';

class ActionsButton extends StatefulWidget {
  @override
  _ActionsButtonState createState() => _ActionsButtonState();
}

class _ActionsButtonState extends State<ActionsButton> {
  @override
  Widget build(BuildContext context) {
    return actionsButtonBuild();
  }

  Widget actionsButtonBuild() {
    return ListTile(
      leading: Icon(Icons.add_box),
      title: Text("Add new book"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddNewBookScreen(),
          ),
        );
      },
    );
  }
}
