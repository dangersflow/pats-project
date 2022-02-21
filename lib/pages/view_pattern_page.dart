import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:pats_project/components/leaderboard.dart';
import 'package:pats_project/components/pattern_display.dart';
import 'package:pats_project/components/tile_selector%20with_pool.dart';
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
  List<Tile> leftTileColumn = [];
  List<Tile> bottomTileRow = [];
  List<Map> leaderboard = [];
  List<Map> grid = [];
  List<Tile> currentTilePool = [];
  List<Tile> finalSelectedTilePool = [];
  Tile currentlySelectedTile = Tile(color: Colors.black);
  bool hasATileSelected = false;
  int x = 1;
  int y = 1;
  String name = '';

  //bool flags for loading the tilePool, leaderboard, and grid
  bool tilePoolLoaded = false;
  bool leaderboardLoaded = false;
  bool gridLoaded = false;
  bool columnLoaded = false;
  bool rowLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  void populateGlues() {
    setState(() {
      for (int i = 0; i < x; i++) {
        bottomTileRow.add(Tile(
          color: Colors.transparent,
          showBorder: true,
        ));
      }
      rowLoaded = true;
    });

    setState(() {
      for (int i = 0; i < y; i++) {
        leftTileColumn.add(Tile(
          color: Colors.transparent,
          showBorder: true,
        ));
      }
      columnLoaded = true;
    });
  }

  void autoPopulateGlues() {
    //auto populate the glues
    setState(() {
      rowLoaded = false;
      List<Tile> tempArray = [];
      for (int i = 0; i < x; i++) {
        tempArray.add(Tile(
          color: Colors.red,
          showBorder: true,
          showGlues: true,
          glues: const {'N': 'X', 'S': ' ', 'E': ' ', 'W': ' '},
        ));
      }
      bottomTileRow = tempArray;
      rowLoaded = true;
    });

    setState(() {
      columnLoaded = false;
      List<Tile> tempArray = [];
      for (int i = 0; i < x; i++) {
        tempArray.add(Tile(
          color: Colors.red,
          showBorder: true,
          showGlues: true,
          glues: const {'N': ' ', 'S': ' ', 'E': 'X', 'W': ' '},
        ));
      }
      leftTileColumn = tempArray;
      columnLoaded = true;
    });
  }

  void addTileToFinalPool(Tile tile) {
    setState(() {
      finalSelectedTilePool.add(tile);
    });
  }

  void changeCurrentTile(Color color) {
    setState(() {
      currentlySelectedTile = Tile(color: color);
      hasATileSelected = true;
    });
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
        List<dynamic>.from(value.docs.first.data()['tilePool'])
            .forEach((element) {
          print(element['color']);
          tilePool.add(Tile(
            color: Color(element['color']),
          ));
        });
        tilePoolLoaded = true;
      });
      setState(() {
        x = value.docs[0].get('pattern_dimension_x');
        y = value.docs[0].get('pattern_dimension_y');
        name = value.docs[0].get('keyPattern');

        populateGlues();
        print(leftTileColumn.length);
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
              context.go('/patterns');
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
         .       .             .             . .            .
         .       patternHeader patternHeader . leaderboard  .
         .       pattern       pattern       . leaderboard  .
         .       pattern       pattern       . leaderboard  .
         .       buttons       buttons       . .            .
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
            Row(
              children: [
                Wrap(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            autoPopulateGlues();
                          });
                        },
                        child: Text("Auto Populate Glues"))
                  ],
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ).inGridArea('buttons'),
            AnimatedOpacity(
              opacity: gridLoaded && columnLoaded && rowLoaded ? 1 : 0,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOutExpo,
              child: AnimatedContainer(
                margin: gridLoaded && columnLoaded && rowLoaded
                    ? EdgeInsets.fromLTRB(0, 0, 0, 0)
                    : EdgeInsets.fromLTRB(0, 50, 0, 0),
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOutExpo,
                child: SizedBox(
                  child: PatternDisplay(
                    grid: grid,
                    x: x,
                    y: y,
                    col: leftTileColumn,
                    row: bottomTileRow,
                  ),
                  width: MediaQuery.of(context).size.width / 3,
                ),
              ),
            ).inGridArea('pattern'),
            PageTransitionSwitcher(
                duration: const Duration(milliseconds: 300),
                reverse: !widget.isTileEntryVisible,
                child: widget.isTileEntryVisible
                    ? TileSelectorWithPool(
                        tilePool: tilePool,
                        finalTilePool: finalSelectedTilePool,
                        changeCurrentTile: changeCurrentTile,
                        currentTileSelected: currentlySelectedTile,
                        hasSelectedTile: hasATileSelected,
                        addTileToPool: addTileToFinalPool,
                        hideTileSetEntry: hideTileSetEntry,
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
                }).inGridArea('leaderboard'),
          ],
        ));
  }
}
