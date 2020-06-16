import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Item {
  const Item(this.name);
  final String name;
}

class AddNewBookScreen extends StatefulWidget {
  @override
  _AddNewBookScreenState createState() => _AddNewBookScreenState();
}

class _AddNewBookScreenState extends State<AddNewBookScreen> {
  Item selectedChoice;
  List<Item> names = <Item>[
    Item("Sci Fiction"),
    Item("Adventure"),
    Item("Horror"),
    Item("Manga"),
    Item("Comics"),
    Item("Bla1"),
    Item("Bla2"),
    Item("Bla3"),
  ];
  TextEditingController titleController;
  final globalKey = GlobalKey<ScaffoldState>();

  /// Function That Displays An `AlertDialog`
  Future<void> _alertDialogChoiceScreen(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      getImagefromGallery(context);
                    },
                    child: Text("Gallery"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      getImageFromCamera(context);
                    },
                    child: Text("Camera"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Function That Picks Images From `Camera`
  File image;
  final picker = ImagePicker();
  Future getImageFromCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    try {
      setState(() {
        image = File(pickedFile.path);
      });
    } catch (err) {
      final failedSnackBar = SnackBar(
        content: Text(
          err,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.red,
      );
      globalKey.currentState.showSnackBar(failedSnackBar);
    }
    Navigator.of(context).pop();
  }

  ///Function That Picks Images from `Gallery`
  Future getImagefromGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    try {
      setState(() {
        image = File(pickedFile.path);
      });
    } catch (err) {
      final failedSnackBar = SnackBar(
        content: Text(
          err,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.red,
      );
      globalKey.currentState.showSnackBar(failedSnackBar);
    }
    Navigator.of(context).pop();
  }

  ///Function that decides what widget to display
  Widget decide() {
    if (image == null) {
      return GestureDetector(
        onTap: () {
          _alertDialogChoiceScreen(context);
        },
        child: CircleAvatar(
          backgroundColor: Colors.grey[900],
          child: Center(
            child: Icon(
              Icons.image,
              size: 40,
              color: Colors.white,
            ),
          ),
          radius: MediaQuery.of(context).size.width * 0.2,
        ),
      );
    } else {
      return Container(
        child: Image.file(image),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final savedSnackBar = SnackBar(
      content: Text(
        "Added successfully",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      backgroundColor: Colors.green,
    );
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {
              globalKey.currentState.showSnackBar(savedSnackBar);
              // TODO: Add FireStore functionality
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Add New Book"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //! TODO:- To be implemented
              /// `Book Pic`
              decide(),

              /// `Button for ImagePic`
              /*Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width:MediaQuery.of(context).size.width ,
                  height: 20,
                  child: FlatButton(
                    child: Text("Select Book Image"),
                    onPressed:(){
                      _alertDialogChoiceScreen(context);
                    }
                  ),
                ),
              ),*/
              /// `Book Name`
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 15.0,
                    ),
                    child: Text(
                      "Book name :-",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      controller: titleController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: "Ex :- David Copperfield",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {
                          titleController.text = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              /// `Author Name`

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 15.0,
                    ),
                    child: Text(
                      "Author name :-",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: "Ex :- Charles Dickens",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              /// `Enter Price`

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 15.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Enter price :-",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Ex :- 60\$",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        onFieldSubmitted: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// `Select Category`

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Select Category :-",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  DropdownButton<Item>(
                    hint: Text("Choose.."),
                    value: selectedChoice,
                    items: names.map((Item item) {
                      return DropdownMenuItem<Item>(
                        value: item,
                        child: Text(item.name),
                      );
                    }).toList(),
                    onChanged: (Item value) {
                      setState(() {
                        selectedChoice = value;
                      });
                    },
                  ),
                ],
              ),

              /// `Select SubCategory`

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Select SubCategory :-",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  DropdownButton<Item>(
                    hint: Text("Choose.."),
                    value: selectedChoice,
                    items: names.map((Item item) {
                      return DropdownMenuItem<Item>(
                        value: item,
                        child: Text(item.name),
                      );
                    }).toList(),
                    onChanged: (Item value) {
                      setState(() {
                        selectedChoice = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
