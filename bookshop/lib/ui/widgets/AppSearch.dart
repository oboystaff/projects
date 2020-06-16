
import 'package:E_Soor/models/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppSearch extends SearchDelegate<String> {
  @override
  TextInputType get keyboardType => TextInputType.text;

  final items = List<String>.generate(100, (i) => "Item $i");

  final recentItems = List<String>.generate(31, (i) => "Item $i");

  @override
  ThemeData appBarTheme(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return themeNotifier.getTheme();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isNotEmpty
          ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                query = "";
              },
            )
          : IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {},
            ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentItems
        : items
            .where((p) => p.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        final String suggestion = suggestions[index];

        return ListTile(
          onTap: () {
            showResults(context);
          },
          leading: query.isEmpty ? Icon(Icons.history) : Icon(Icons.book),
          title: RichText(
            text: TextSpan(
              text: suggestion,
              style: TextStyle(
                color: Colors.orange[300],
              ),
            ),
          ),
        );
      },
      itemCount: suggestions.length,
    );
  }
}

void showSearchPage(
    BuildContext context, SearchDelegate search, String transcription) async {
  final String selected = await showSearch(
    context: context,
    delegate: search,
    query: transcription,
  );

  if (selected != null) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("You chose this"),
      ),
    );
  }
}
