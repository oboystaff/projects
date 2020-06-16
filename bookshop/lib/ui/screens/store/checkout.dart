import 'dart:ffi';

import 'package:flutter/material.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  Float totalPrice;
  int booksAmmount = 46375;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        elevation: 1,
        title: Text(
          "Credit Card Payment",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ///
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text("Insert Your Payment Info"),
                    ),
                  ),

                  /// Text Field For Card Number
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLength: 16,
                      decoration: InputDecoration(
                        labelText: "Card Number",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  /// MM && YY TextFields
                  Wrap(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            maxLength: 2,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: "MM"),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: "YY"),
                          ),
                        ),
                      )
                    ],
                  ),

                  /// Security CODE TextField
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: "Security Code"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Text(
                              "The 3 or 4 digits at the back of your card"),
                        )
                      ],
                    ),
                  ),

                  /// Name && LastName TextFields
                  Wrap(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(labelText: "Name"),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(labelText: "LastName"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          minLines: 1,
                          maxLines: 5,
                          decoration:
                              InputDecoration(labelText: "Billing Address"),
                        ),
                      ),
                    ],
                  ),

                  ///payment summary
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                border: Border(
                  top: BorderSide(
                    width: 2,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              width: MediaQuery.of(context).size.width * 1,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      height: 40,
                      child: Center(
                        child: Text('Payment Summary'),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Total Price:",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              'Books Ammount:',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "$totalPrice LE",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              '$booksAmmount',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          child: RaisedButton(
                            onPressed: () {},
                            elevation: 0,
                            child: Text(
                              "Confirm Order",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
