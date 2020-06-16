import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AuthorPage extends StatefulWidget {
  @override
  _AuthorPageState createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
       
        appBar: AppBar(),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            /// This Row is for the avater and the info besides

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                /// This is the avater

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundImage: ExactAssetImage("assets/images/omar.jpg"),
                    radius: 80,
                  ),
                ),

                /// This is Column to wrap all the info besides the avatar

                Column(
                  children: <Widget>[
                    /// Here is the `Author Name`

                    Text(
                      "Author Name",
                      style: Theme.of(context).textTheme.headline6,
                    ),

                    /// Here is `The number of written books`

                    Row(
                      children: <Widget>[
                        Text(
                          "86",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .merge(Theme.of(context).textTheme.subtitle1),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(MdiIcons.book),
                        ),
                      ],
                    ),

                    /// Here is the `Rating Indicator Bar`

                    RatingBarIndicator(
                      rating: 4.4,
                      itemSize: 30,
                      unratedColor: Colors.white,
                      itemCount: 5,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            /// A Divider to split all of the above from the `CustomExpansionPanelList`
            Divider(
              height: 40,
              thickness: 5,
              color: Theme.of(context).dividerColor,
              indent: width * 0.25,
              endIndent: width * 0.25,
            ),

            /// This is the `CustomExpansionPanelList` where `Bio - Bestsellers - Quotes` gonna be in it
            CustomExpansionPanelList(),
          ],
        ),
      ),
    );
  }
}

//! This is separating line between the below custom widget and the author page

/// stores ExpansionPanel state information
class Item {
  Item({
    this.headerValue,
    this.isExpanded = false,
    this.bodyValue,
  });

  Widget headerValue;
  Widget bodyValue;
  bool isExpanded;
}

List<Item> items = [
  Item(
    headerValue: ListTile(
      leading: Icon(Icons.info_outline),
      title: Text("Bio"),
    ),

    /// Here we will display some information about the `author's life`

    bodyValue: Text("\n\n\n\n\n\n\n\n\n\n"),
    isExpanded: true,
  ),
  Item(
    headerValue: ListTile(
      leading: Icon(MdiIcons.bookshelf),
      title: Text("Bestsellers"),
    ),

    /// This should be a `listView` or `GridView` for displaying the top 20 bestsellers

    bodyValue: Text("blablablablabla"),
  ),
  Item(
    headerValue: ListTile(
      leading: Icon(MdiIcons.commentQuoteOutline),
      title: Text("Quotes"),
    ),

    /// This should be a `listView` or `GridView` for displaying the quotes

    bodyValue: Text("blablablablabla"),
  ),
];

class CustomExpansionPanelList extends StatefulWidget {
  @override
  _CustomExpansionPanelListState createState() =>
      _CustomExpansionPanelListState();
}

class _CustomExpansionPanelListState extends State<CustomExpansionPanelList> {
  @override
  Widget build(BuildContext context) {
    return _buildPanel();
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(
          () {
            items[index].isExpanded = !isExpanded;
          },
        );
      },
      children: items.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return item.headerValue;
          },
          body: item.bodyValue,
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
