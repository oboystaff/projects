import 'package:flutter/material.dart';

AppBar selectionAppBar(context) {
  int number = 1;
  return AppBar(
    centerTitle: true,
    title: Text(
      "$number category is selected",
      style: Theme.of(context).textTheme.subtitle1,
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.delete),
      ),
      PopupMenuButton(
        itemBuilder: (_) => [
          PopupMenuItem(
            child: Chip(
              label: Text("Edit"),
              avatar: Icon(Icons.edit),
            ),
          ),
          PopupMenuItem(
            child: Chip(
              label: Text("Report"),
              avatar: Icon(Icons.report_problem),
            ),
          ),
        ],
      ),
    ],
  );
}
