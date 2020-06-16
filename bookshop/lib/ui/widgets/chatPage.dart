import 'package:flutter/material.dart';

/*class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatPageView(),
    );
  }
}

/// the class that holds the
class ReceivedMessageWidget extends StatelessWidget {
  final String content;
  final String time;
  const ReceivedMessageWidget({
    Key key,
    this.content,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding:
          const EdgeInsets.only(right: 75.0, left: 8.0, top: 8.0, bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)),
        child: Container(
          color: Colors.blue,
          child: Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  right: 12.0, left: 23.0, top: 8.0, bottom: 15.0),
              child: Text(
                "يا بروو انت اكتر وااله",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 10,
              child: Text("12:54",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  )),
            )
          ]),
        ),
      ),
    ));
  }
}

class SendedMessageWidget extends StatelessWidget {
  final String content;
  final String time;
  const SendedMessageWidget({
    Key key,
    this.content,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
            right: 8.0, left: 75.0, top: 8.0, bottom: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)),
          child: Container(
            color: Colors.orange,
            // margin: const EdgeInsets.only(left: 10.0),
            child: Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    right: 12.0, left: 23.0, top: 8.0, bottom: 15.0),
                child: Text(
                    "يسطا واحشني فششخ عامل ايه",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
              ),
              Positioned(
                bottom: 5,
                right: 10,
                child: Text(
                  "12:55",
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class ChatPageView extends StatefulWidget {
  final String username;

  const ChatPageView({
    Key key,
    this.username,
  }) : super(key: key);

  @override
  _ChatPageViewState createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  TextEditingController _text = new TextEditingController();
  ScrollController _scrollController = ScrollController();
  var childList = <Widget>[];

  @override
  void initState() {
    super.initState();
    childList.add(Align(
        alignment: Alignment(0, 0),
        child: Container(
          margin: const EdgeInsets.only(top: 5.0),
          height: 25,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              )),
          child: Center(
              child: Text(
            "Today",
            style: TextStyle(fontSize: 11),
          )),
        )));
    childList.add(Align(
      alignment: Alignment(1, 0),
      child: SendedMessageWidget(
        content: 'Hello',
        time: '21:36 PM',
      ),
    ));
    childList.add(Align(
      alignment: Alignment(1, 0),
      child: SendedMessageWidget(
        content: 'How are you? What are you doing?',
        time: '21:36 PM',
      ),
    ));
    childList.add(Align(
      alignment: Alignment(-1, 0),
      child: ReceivedMessageWidget(
        content: 'Hello, Mohammad.I am fine. How are you?',
        time: '22:40 PM',
      ),
    ));
    childList.add(Align(
      alignment: Alignment(1, 0),
      child: SendedMessageWidget(
        content:
            'I am good. Can you do something for me? I need your help my bro.',
        time: '22:40 PM',
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 65,
                    child: Container(
                      color: Colors.black,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.username ?? "Jimi Cooke",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Text(
                                "online",
                                style: TextStyle(
                                    color: Colors.white60, fontSize: 12),
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                            child: Container(
                              child: ClipRRect(
                                child: Container(
                                    child: SizedBox(
                                      child: Image.network(
                                        "",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    color: Colors.black),
                                borderRadius: new BorderRadius.circular(50),
                              ),
                              height: 55,
                              width: 55,
                              padding: const EdgeInsets.all(0.0),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: Colors.black54,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: childList,
                          )),
                    ),
                  ),
                  Divider(height: 0, color: Colors.black26),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      maxLines: 6,
                      minLines: 1,
                      controller: _text,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        border: InputBorder.none,
                        hintText: "enter your message",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
