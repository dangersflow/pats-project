import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:pats_project/components/leaderboard.dart';
import 'package:pats_project/components/pattern_display.dart';
import 'package:pats_project/components/tile_set_entry.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:go_router/go_router.dart';
import 'package:pats_project/components/tile.dart';
import 'package:animate_do/animate_do.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewPatternPage extends StatefulWidget {
  bool isTileEntryVisible;
  String? projectKey;
  ViewPatternPage(
      {Key? key, this.isTileEntryVisible = false, required this.projectKey})
      : super(key: key);

  @override
  _ViewPatternPageState createState() => _ViewPatternPageState();
}

class _ViewPatternPageState extends State<ViewPatternPage> {
  List<Tile> tilePool = [];
  List<Map> leaderboard = [];
  List<Map> grid = [];
  int x = 1;
  int y = 1;
  String name = '';

  //bool flags for loading the tilePool, leaderboard, and grid
  bool tilePoolLoaded = false;
  bool leaderboardLoaded = false;
  bool gridLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection('patterns')
        .where('keyPattern', isEqualTo: widget.projectKey!)
        .get()
        .then((value) {
      var jsonData = jsonEncode(value.docs.first.data().toString());
      var decodedData = jsonDecode(jsonData);

      setState(() {
        List<dynamic>.from(value.docs.first.data()['grid']).forEach((element) {
          grid.add(element);
        });
        gridLoaded = true;
      });
      setState(() {
        List<dynamic>.from(value.docs.first.data()['leaderboard'])
            .forEach((element) {
          leaderboard.add(element);
        });
        leaderboardLoaded = true;
      });
      setState(() {
        x = value.docs[0].get('pattern_dimension_x');
        y = value.docs[0].get('pattern_dimension_y');
        name = value.docs[0].get('keyPattern');
      });
    });
  }

  void showTileSetEntry() {
    setState(() {
      widget.isTileEntryVisible = true;
    });
  }

  void hideTileSetEntry() {
    setState(() {
      widget.isTileEntryVisible = false;
    });
  }

  void updateData(List<Map> data) {
    setState(() {
      leaderboard = data;
      leaderboard
          .sort((a, b) => (a['tileSet'].length).compareTo(b['tileSet'].length));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: InkWell(
            child: Text("PATS PROJECT"),
            onTap: () {
              context.go('/');
            },
            splashColor: Colors.transparent,
            enableFeedback: false,
            splashFactory: NoSplash.splashFactory,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ),
        body: LayoutGrid(
          areas: '''
         . .             .             . .            .
         . patternHeader patternHeader . .            .
         . pattern       pattern       . leaderboard  .
         . pattern       pattern       . leaderboard  .
         . footer        footer        . .            .
        ''',
          columnSizes: [0.2.fr, 1.fr, auto, auto, 1.fr, 0.2.fr],
          rowSizes: [
            0.1.fr,
            0.2.fr,
            1.fr,
            1.fr,
            0.1.fr,
          ],
          // Column and row gaps! 🔥
          columnGap: 12,
          rowGap: 12,
          children: [
            Text(
              name,
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width / 50),
            ).inGridArea('patternHeader'),
            AnimatedOpacity(
              opacity: gridLoaded ? 1 : 0,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOutExpo,
              child: AnimatedContainer(
                margin: gridLoaded
                    ? EdgeInsets.fromLTRB(0, 0, 0, 0)
                    : EdgeInsets.fromLTRB(0, 50, 0, 0),
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOutExpo,
                child: SizedBox(
                  child: PatternDisplay(
                    grid: grid,
                    x: x,
                    y: y,
                  ),
                  width: MediaQuery.of(context).size.width / 3,
                ),
              ),
            ).inGridArea('pattern'),
            PageTransitionSwitcher(
                duration: const Duration(milliseconds: 300),
                reverse: !widget.isTileEntryVisible,
                child: widget.isTileEntryVisible
                    ? TileSetEntry(
                        hideTileSetEntry: hideTileSetEntry,
                        exampleData: leaderboard,
                        updateData: updateData,
                      )
                    : Leaderboard(
                        listData: leaderboard,
                        onAddEntry: showTileSetEntry,
                      ),
                transitionBuilder:
                    (child, primaryAnimation, secondaryAnimation) {
                  return SharedAxisTransition(
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    child: child,
                  );
                }).inGridArea('leaderboard')
          ],
        )
        // Center(
        //   child: Column(
        //     children: [
        //       Row(children: [
        //         const Padding(padding: EdgeInsets.fromLTRB(100, 150, 0, 0)),
        //         Text(
        //           'Demo Pattern',
        //           style:
        //               TextStyle(fontSize: MediaQuery.of(context).size.width / 50),
        //         ),
        //       ]),
        //       Row(
        //         children: [
        //           SizedBox(
        //               child: PatternDisplay(x: 5, y: 5),
        //               width: MediaQuery.of(context).size.width / 3,
        //               height: MediaQuery.of(context).size.width / 3),
        //           const Padding(padding: EdgeInsets.fromLTRB(150, 0, 0, 0)),
        //           widget.isTileEntryVisible
        //               ? SizedBox(
        //                   child: TileSetEntry(
        //                     hideTileSetEntry: hideTileSetEntry,
        //                     exampleData: exampleData,
        //                     updateData: updateData,
        //                   ),
        //                   width: MediaQuery.of(context).size.width / 3,
        //                   height: MediaQuery.of(context).size.width / 3)
        //               : SizedBox(
        //                   child: Leaderboard(
        //                     listData: exampleData,
        //                     onAddEntry: showTileSetEntry,
        //                   ),
        //                   width: MediaQuery.of(context).size.width / 3,
        //                   height: MediaQuery.of(context).size.width / 3,
        //                 ),
        //         ],
        //         mainAxisAlignment: MainAxisAlignment.center,
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
