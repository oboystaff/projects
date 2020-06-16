import 'package:E_Soor/models/category_model.dart';
import 'package:E_Soor/models/selection.dart';
import 'package:E_Soor/ui/widgets/categoryItems.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

String categoryName(name) {
  if (name != null) {
    return name;
  } else {
    return "Category Name";
  }
}

final Category category = Category();

Widget onViewMoreBuild(onViewMore) {
  if (onViewMore != null) {
    return FlatButton(
      onPressed: onViewMore,
      child: Text(
        "view more".toUpperCase(),
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  } else {
    return Container(
      height: 0,
      width: 0,
    );
  }
}

Widget _buildCategoryBar(context, onTap, onViewMore, name, isSelected) {
  if (isSelected == true) {
    return Wrap(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(MdiIcons.checkboxMarkedCircle),
        ),
        Container(
          width: double.infinity,
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              // Category Header
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          categoryName(name),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onViewMoreBuild(onViewMore)
                      ],
                    ),
                  ),
                ],
              ),
              // Category Items
              categoryItems(context, onTap, Axis.horizontal),
              // Spacer
              Divider(
                color: Colors.white,
                thickness: 4,
                height: 30,
                endIndent: MediaQuery.of(context).size.width * 0.35,
                indent: MediaQuery.of(context).size.width * 0.35,
              )
            ],
          ),
        ),
      ],
    );
  } else {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          // Category Header
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  categoryName(name),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onViewMoreBuild(onViewMore)
              ],
            ),
          ),
          // Category Items
          categoryItems(context, onTap, Axis.horizontal),
          // Spacer
          Divider(
            color: Colors.white,
            thickness: 4,
            height: 30,
            endIndent: MediaQuery.of(context).size.width * 0.35,
            indent: MediaQuery.of(context).size.width * 0.35,
          )
        ],
      ),
    );
  }
}

class CategoryBar extends StatefulWidget {
  final BuildContext context;
  final String name;
  final Function onViewMore;
  final Function onTap;

  CategoryBar(
    this.context,
    this.onTap,
    this.onViewMore,
    this.name,
  );
  @override
  _CategoryBarState createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  @override
  Widget build(BuildContext context) {
    var selectionProvider = Provider.of<SelectionNotifier>(context);

    bool isSelected = selectionProvider.getValue();

    return GestureDetector(
      onLongPress: () {
        if (isSelected) {
          return selectionProvider.setValue(false);
        } else {
          return selectionProvider.setValue(true);
        }
      },
      child: _buildCategoryBar(
        context,
        widget.onTap,
        widget.onViewMore,
        widget.name,
        isSelected,
      ),
    );
  }
}
