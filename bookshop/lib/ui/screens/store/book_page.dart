/*import 'package:E_Soor/ui/screens/store/authorPage.dart';*/
import 'package:E_Soor/ui/widgets/AppSearch.dart';
import 'package:E_Soor/ui/widgets/previewImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookPage extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<BookPage> {
  int price = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: AppSearch(),
              );
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: InkWell(
                  onTap: () {
                    print("Tapped");
                    showDialog(
                      context: context,
                      builder: (_) => SimpleDialog(
                        title: ListTile(
                          leading: Icon(Icons.report_problem),
                          title: Text("Report a problem"),
                          trailing: Icon(Icons.close),
                        ),
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: SizedBox.expand(),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RaisedButton(
                                child: Text("Cancel"),
                                onPressed: () {},
                              ),
                              RaisedButton(
                                child: Text("Send"),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    );
                  },
                  child: Chip(
                    backgroundColor: Colors.blueGrey,
                    label: Text("Report"),
                    avatar: Icon(Icons.flag),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return;
        },
        child: SingleChildScrollView(
          child: ListView(
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              BookInfo(),
              BookFeedBack(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: BookRating(),
              ),
              PeopelBookFeedBack(),
            ],
          ),
        ),
      ),
    );
  }
}

/// THIS IS THE CLASS THAT HOLDS THE `book Info`
class BookInfo extends StatefulWidget {
  @override
  _BookInfoState createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  ///Essential `variables`
  int price = 60;
  String authorName;
  String bookName;
  int rating;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 300,
      width: MediaQuery.of(context).size.width * 1,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ///The column Which holds the `Book INFO`
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    /// This is the `BOOK NAME`
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "David copper field",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    /// This is the `Author Name`
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "by:-Charles dickens",
                      ),
                    ),

                    /// This is the `Rating of the book`
                    RatingBarIndicator(
                      rating: 4,
                      itemSize: 30,
                      unratedColor: Colors.white,
                      itemCount: 5,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),

                    ///This is the `CATEGORY BUTTON`
                    RaisedButton(
                      elevation: 0.0,
                      child: Text(
                        "Category",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {},
                    ),

                    ///This is the `PRICE`
                    Text("price:-$price"),
                  ],
                ),
              ),
            ),
          ),

          /// The `Book Image`
          Expanded(
            flex: 5,
            child: Container(
              height: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreviewImage(),
                      ),
                    );
                  },
                  child: Image.network(
                    "https://maktabati.me/files/2018/03/davidcopperfield-260x300.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// THIS IS A CLASS WHICH `BOOK RATING BAR`
class BookRating extends StatefulWidget {
  @override
  _BookRatingState createState() => _BookRatingState();
}

class _BookRatingState extends State<BookRating> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: <Widget>[
          Text("Rate The Book"),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: RatingBar(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///THIS IS THE CLASS THAT HOLDS THE `TEXT FIELD FOR WRITING BOOK FEEDBACK`
class BookFeedBack extends StatefulWidget {
  @override
  _BookFeedBackState createState() => _BookFeedBackState();
}

class _BookFeedBackState extends State<BookFeedBack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width * 1,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: TextField(
          minLines: 1,
          maxLines: 5,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {},
            ),
            labelText: "Write your feedback about the book",
          ),
        ),
      ),
    );
  }
}

/// THIS IS THE CLASS THAT HOLDS `THE EXPANSIION PANNEL LIST OF BOOK FEEDBACKS FROM DIFFERENT USERES`
class PeopelBookFeedBack extends StatefulWidget {
  @override
  _PeopelBookFeedBackState createState() => _PeopelBookFeedBackState();
}

class _PeopelBookFeedBackState extends State<PeopelBookFeedBack> {
  @override
  Widget build(BuildContext context) {
    return CustomExpansionPanelList();
  }
}

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

/// This is a `List of ExpansionPanels` wrapped in `Item` class which stores the data of the panels

List<Item> items = [
  Item(
    headerValue: ListTile(
      title: Text("See other's feedbacks"),
    ),
    bodyValue: SingleChildScrollView(
      child: Column(
        children: List.generate(
          40,
          (index) => Padding(
            padding: const EdgeInsets.all(20),
            child: Text("This is a book feedback"),
          ),
        ),
      ),
    ),
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
      children: items.map<ExpansionPanel>(
        (Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return item.headerValue;
            },
            body: item.bodyValue,
            isExpanded: item.isExpanded,
          );
        },
      ).toList(),
    );
  }
}
