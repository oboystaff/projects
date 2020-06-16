import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

////This is the main class that holds all of the main profile components
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          /// the Wraper that holds the profile name, bio and picture
          Wrap(children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ProfilePicture(imageUrl: ""),
                  ProfileName(profileName: "Omar Hany Hassan Fouad"),
                  ProfileBio(profileBio: "This is my E-soor Bio"),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      child: FlatButton(
                        color: Colors.grey[700],
                        onPressed: () {},
                        child: Text("Edit Profile"),
                      ),
                    ),
                  ),
                ])
          ]),
        ]);
  }
}

/////Profile picture class

class ProfilePicture extends StatefulWidget {
  final String imageUrl;
  ProfilePicture({Key key, this.imageUrl}) : super(key: key);
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: CircleAvatar(
            radius: 70, backgroundImage: NetworkImage("${widget.imageUrl}")

            ///get the profile image from the database
            ));
  }
}

////Profile name class

class ProfileName extends StatefulWidget {
  final String profileName;

  /// constructor to recieve the data and address it to the variable above
  ProfileName({Key key, this.profileName}) : super(key: key);

  @override
  _ProfileNameState createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: AutoSizeText(
          "${widget.profileName}",

          /// get the value of the string stored inside the profile_name variable
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}

////Profile Bio class

class ProfileBio extends StatefulWidget {
  final String profileBio;
  ProfileBio({Key key, this.profileBio}) : super(key: key);

  @override
  _ProfileBioState createState() => _ProfileBioState();
}

class _ProfileBioState extends State<ProfileBio> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Text(
          '${widget.profileBio}',
        ));
  }
}

///book highlights List View

/*class BookHighlightsList extends StatefulWidget {
  @override
  _BookHighlightsListState createState() => _BookHighlightsListState();
}

class _BookHighlightsListState extends State<BookHighlightsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 250,
      child: ListView.builder(
        itemCount: 3,////the item count should equal the number of the book reviews and highlights in the user's database 
        scrollDirection: Axis.horizontal,
        addAutomaticKeepAlives: true,
        reverse: true,
        shrinkWrap: true,
        itemBuilder: (context, index){
          ///these are the card children of the ListView
          ///The user should be able to add cards to this ListView 
          ///These Cards represents some book reviews 
          return Card(
              child: Container(
                  height: 250,
                  width: 150,
                  child: Card(
                      margin:EdgeInsets.symmetric(vertical: 15, horizontal: 3.5),
                      child: Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.library_books,
                                size: 35,
                              ),
                            onPressed: () { /* by clicking on this users are able to add book reviews */ },
                            ),
                            Text(
                              'Add Book Highlight',
                               style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                )
              )
            )
          );
        }
      ),
    );
  }
}*/
