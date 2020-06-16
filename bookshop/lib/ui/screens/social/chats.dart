import 'package:E_Soor/ui/widgets/AppSearch.dart';
import 'package:E_Soor/ui/widgets/RecentChats.dart';
import 'package:flutter/material.dart';
import 'package:bottomreveal/bottomreveal.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final BottomRevealController _menuController = BottomRevealController();
  static DateTime dateTime = new DateTime.now().toLocal();
  TextEditingController textController = TextEditingController();
  String time = "${dateTime.hour}:${dateTime.minute}";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomReveal(
        frontColor: Colors.grey[800],
        openIcon: Icons.message,
        closeIcon: null,
        revealWidth: 100,
        revealHeight: 100,
        backColor: Colors.grey.shade900,
        rightContent: ListView.separated(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(2, 0, 2, 5),
              child: GestureDetector(
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.orange[400],
                    ),
                    SizedBox.fromSize(
                      size: MediaQuery.of(context).size / 100,
                    ),
                    Text("Name $index"),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 20,
            );
          },
        ),
        bottomContent: TextFormField(
          controller: textController,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            suffixIcon: Icon(Icons.search, color: Colors.white,),
            hintText: "Search your chats..",
            filled: true,
            fillColor: Colors.grey,
            contentPadding: const EdgeInsets.all(8.0),
            border: OutlineInputBorder(
              gapPadding: 8.0,
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onFieldSubmitted: (query) {
            showSearch(context: context, delegate: AppSearch(), query: query);
          },
        ),
        controller: _menuController,
        body: RecentChats(),
      ),
    );
  }
}
