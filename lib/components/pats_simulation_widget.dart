import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pats_project/components/leaderboard_entry_card.dart';
import 'package:pats_project/components/pats_simulation.dart';
import 'package:pats_project/components/pattern_display.dart';
import 'package:pats_project/components/tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pats_project/components/tile_pool_with_anim.dart';
import 'package:go_router/go_router.dart';

class PATSSimulationWidget extends StatefulWidget {
  List<Tile> grid;
  List<Tile> bottomGlueRow;
  List<Tile> leftGlueColumn;
  List<Tile> tilePool;
  Function() hideTileSetEntry;
  String? projectKey;
  int x;
  int y;
  PATSSimulationWidget(
      {Key? key,
      required this.grid,
      required this.bottomGlueRow,
      required this.leftGlueColumn,
      required this.tilePool,
      required this.x,
      required this.y,
      required this.hideTileSetEntry,
      this.projectKey})
      : super(key: key);

  @override
  _PATSSimulationWidgetState createState() => _PATSSimulationWidgetState();
}

class _PATSSimulationWidgetState extends State<PATSSimulationWidget> {
  List<Tile> resultingGrid = [];
  List<Map> gridMap = [];
  List<Map> resultingGridMap = [];
  List<Tile> transparancyGrid = [];
  List<Map> currentLeaderboard = [];
  String projectId = '';
  bool performAnimation = false;
  bool verification = false;
  bool simulationFinished = false;
  CollectionReference patterns =
      FirebaseFirestore.instance.collection('patterns');

  List<Map> convertGridToMap(List<Tile> grid) {
    List<Map> tempList = [];

    for (int i = 0; i < grid.length; i++) {
      tempList.add(grid[i].toMap());
    }

    return tempList;
  }

  Future<void> addToLeaderboard(Map personObject) async {
    //first get leaderboard
    await FirebaseFirestore.instance
        .collection('patterns')
        .where('keyPattern', isEqualTo: widget.projectKey!)
        .get()
        .then((value) {
      var jsonData = jsonEncode(value.docs.first.data().toString());
      var decodedData = jsonDecode(jsonData);
      print(decodedData);
      print(value.docs.first.id);
      projectId = value.docs.first.id;
      setState(() {
        List<dynamic>.from(value.docs.first.data()['leaderboard'])
            .forEach((element) {
          currentLeaderboard.add(element);
        });
      });
    });

    //add map object to our leaderboard :)
    currentLeaderboard.add(personObject);

    return patterns
        .doc(projectId)
        .update({'leaderboard': currentLeaderboard}).then((value) {
      context.go('/patterns/' + widget.projectKey.toString());
    });
  }

  List<Tile> TileGridToTransparentTileGrid(List<Tile> grid) {
    List<Tile> temp = [];

    for (int i = 0; i < grid.length; i++) {
      //set current tile transparency
      Tile currentTile = grid[i];
      currentTile.color = currentTile.color.withOpacity(0.5);
      temp.add(currentTile);
    }

    return temp;
  }

  void setResultingGrid(List<Tile> grid) {
    setState(() {
      resultingGrid = grid;
      resultingGridMap = convertGridToMap(grid);
      print("here I am :)");
      print("wpw");
      print(resultingGridMap);
    });

    setState(() {
      performAnimation = true;
      gridMap = resultingGridMap;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transparancyGrid = TileGridToTransparentTileGrid(widget.grid);
    gridMap = convertGridToMap(transparancyGrid);
  }

  //check if the resulting grid and the grid are the same
  bool checkIfSame(List<Map> grid1, List<Map> grid2) {
    if (grid1.length != grid2.length) {
      return false;
    }

    for (int i = 0; i < grid1.length; i++) {
      if (grid1[i]['color'] != grid2[i]['color']) {
        return false;
      }
    }

    return true;
  }

  bool checkIfSameLength(List<Map> grid1, List<Map> grid2) {
    if (grid1.length != grid2.length) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    PATSSimulation mainSimulation = PATSSimulation(
        x: widget.x,
        y: widget.y,
        mainGrid: widget.grid,
        leftGlueColumn: widget.leftGlueColumn,
        bottomGlueRow: widget.bottomGlueRow,
        resultingGrid: resultingGrid,
        tilePool: widget.tilePool,
        setResultingGrid: setResultingGrid);

    return Stack(
      children: [
        LayoutGrid(
          areas: '''
      .       .       .         .       .      .
      .       pattern pattern   button  button .
      .       pattern pattern   button  button .
      .       bag     bag       button  button .
      .       .       .         .       .      .  
      ''',
          columnSizes: [
            0.1.fr,
            1.fr,
            1.fr,
            1.fr,
            1.fr,
            0.2.fr,
          ],
          rowSizes: [0.2.fr, 1.fr, 0.7.fr, 1.fr, 0.2.fr],
          children: [
            Center(
              child: FittedBox(
                child: Column(
                  children: [
                    Text("Grid",
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.013)),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0,
                                MediaQuery.of(context).size.width * 0.03, 0)),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: PatternDisplay(
                              x: widget.x,
                              y: widget.y,
                              grid: gridMap,
                              col: widget.leftGlueColumn,
                              row: widget.bottomGlueRow,
                              doAnim: performAnimation,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ).inGridArea('pattern'),
            Center(
              child: FittedBox(
                child: Column(
                  children: [
                    Text("Your Tile Pool",
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.015)),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0,
                                MediaQuery.of(context).size.width * 0.07, 0)),
                        Center(
                            child: TilePoolWithAnim(
                                mainTilePool: widget.tilePool)),
                      ],
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ).inGridArea('bag'),
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: PageTransitionSwitcher(
                        duration: const Duration(milliseconds: 300),
                        reverse: !simulationFinished,
                        child: simulationFinished
                            ? LeaderboardEntryCard(
                                verification: verification,
                                numTiles: widget.tilePool.length,
                                addToLeaderboard: addToLeaderboard,
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(20)),
                                onPressed: () {
                                  mainSimulation.simulateInOrder();

                                  List<Map> temp = convertGridToMap(
                                      mainSimulation.resultingGrid);
                                  //check if the resulting grid has the same length as the grid
                                  //if so, fill the remaining space with the trasparent tiles
                                  if (!checkIfSameLength(temp, gridMap)) {
                                    mainSimulation
                                        .fillRemainingSpace(transparancyGrid);
                                  }

                                  setResultingGrid(
                                      mainSimulation.resultingGrid);

                                  //verification
                                  setState(() {
                                    verification =
                                        checkIfSame(resultingGridMap, temp);
                                    print(verification);
                                    simulationFinished = true;
                                  });
                                },
                                child: Text(
                                  "Start Simulation!",
                                  style: TextStyle(fontSize: 22),
                                )),
                        transitionBuilder:
                            (child, primaryAnimation, secondaryAnimation) {
                          return SharedAxisTransition(
                            animation: primaryAnimation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.horizontal,
                            child: child,
                          );
                        }),
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         verification = checkIfSame(resultingGridMap, gridMap);
                  //         isSimulating = false;
                  //       });
                  //     },
                  //     child: Text("Verify"))
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ).inGridArea('button')
          ],
        ),
        // !isSimulating && verification
        //     ? Center(
        //         child: ZoomIn(
        //           child: Icon(
        //             Icons.verified,
        //             size: MediaQuery.of(context).size.width * 0.2,
        //           ),
        //           animate: verification,
        //         ),
        //       )
        //     : Container(),
      ],
    );
  }
}
