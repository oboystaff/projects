import 'package:E_Soor/helpers/logic/constants.dart';
import 'package:E_Soor/models/selection.dart';
import 'package:E_Soor/ui/screens/tabs/social.dart';
import 'package:E_Soor/ui/screens/tabs/store.dart';
import 'package:E_Soor/ui/widgets/AppSearch.dart';
import 'package:E_Soor/ui/widgets/ThemeSwitch.dart';
import 'package:E_Soor/ui/widgets/selectionAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody>
    with SingleTickerProviderStateMixin {
  String transcription = "";
  TabController tabController;
  ScrollController scrollViewController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    scrollViewController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var selectionProvider = Provider.of<SelectionNotifier>(context);
    bool isSelected = selectionProvider.getValue();

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          controller: scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: true,
                title: FlatButton(
                  onPressed: () {
                    showSearchPage(context, AppSearch(), transcription);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        size: 25,
                      ),
                      Text(
                        " Search",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                titleSpacing: 0,
                actions: <Widget>[
                  Constants(
                    child: ThemeSwitch(),
                  ),
                ],
                floating: true,
                pinned: true,
                forceElevated: innerBoxIsScrolled,
                bottom: isSelected
                    ? selectionAppBar(context)
                    : TabBar(
                        controller: tabController,
                        indicatorColor: Colors.white,
                        tabs: <Widget>[
                          Tab(
                            text: "Store",
                            icon: Icon(
                              Icons.store,
                            ),
                          ),
                          Tab(
                            text: "Social",
                            icon: Icon(
                              Icons.people,
                            ),
                          ),
                        ],
                      ),
              ),
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: <Widget>[
              Store(),
              Social(),
            ],
          ),
        ),
      ),
    );
  }
}
