import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:go_router/go_router.dart';
import 'package:pats_project/components/pattern_selector.dart';
import 'package:pats_project/components/tile.dart';
import 'package:pats_project/components/tile_selector.dart';
import 'package:motion_toast/motion_toast.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPatternPage extends StatefulWidget {
  const AddPatternPage({Key? key}) : super(key: key);

  @override
  _AddPatternPageState createState() => _AddPatternPageState();
}

class _AddPatternPageState extends State<AddPatternPage> {
  List<Tile> tilePool = [];
  List<Tile> grid = [];
  List<Map> gridMap = [];
  Tile currentlySelectedTile = Tile(color: Colors.black);
  TextEditingController nameController = TextEditingController();
  TextEditingController xController = TextEditingController();
  TextEditingController yController = TextEditingController();

  void changeCurrentTile(Color color) {
    setState(() {
      currentlySelectedTile = Tile(color: color);
    });
  }

  void addTileToPool(Tile tile) {
    setState(() {
      tilePool.add(tile);
    });
  }

  void convertGridToMap() {
    for (int i = 0; i < grid.length; i++) {
      gridMap.add(grid[i].toMap());
    }
  }

  void createGrid(int x, int y) {
    //create a grid of grey tiles into the grid list
    for (int i = 0; i < x * y; i++) {
      grid.add(Tile(
        color: Colors.grey,
        id: i + 1,
      ));
    }
  }

  void changeGridSize(int x, int y) {
    setState(() {
      grid = [];
      for (int i = 0; i < x * y; i++) {
        grid.add(Tile(
          color: Colors.grey,
          id: i + 1,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference patterns =
        FirebaseFirestore.instance.collection('patterns');

    Future<void> addPattern() {
      //convert current grid to map
      convertGridToMap();
      // Call the user's CollectionReference to add a new user
      return patterns.add({
        'keyPattern': nameController.text, // John Doe// 42
        'pattern_dimension_x': int.parse(xController.text),
        'pattern_dimension_y': int.parse(xController.text),
        'leaderboard': [],
        'grid': gridMap
      }).then((value) {
        print("Pattern Added");
        MotionToast.success(
          description: Text("Pattern Added Successfully!"),
          animationDuration: Duration(milliseconds: 100),
          animationCurve: Curves.easeInOutCubic,
          toastDuration: Duration(milliseconds: 1000),
        ).show(context);
      }).catchError((error) => print("Failed to add pattern: $error"));
    }

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
        . .               . .            .                .
        . header          . .            .                .
        . patternSelector patternSelector tileSelector tileSelector     .
        . footer          footer footer            footer                .
        ''',
        columnSizes: [0.25.fr, 1.0.fr, 0.5.fr, 0.5.fr, 1.fr, 0.2.fr],
        rowSizes: [0.05.fr, 0.10.fr, 1.fr, 0.1.fr],
        children: [
          SizedBox(
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: "Add a New Pattern",
                  label: Text("Name"),
                  hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.025),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 5.0),
                  )),
              onSubmitted: (value) {
                setState(() {
                  nameController.text = value;
                });
              },
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025),
            ),
            width: MediaQuery.of(context).size.width * 0.35,
          ).inGridArea('header'),
          PatternSelector(
            currentlySelectedTile: currentlySelectedTile,
            grid: grid,
            createGrid: createGrid,
            changeGridSize: changeGridSize,
            xController: xController,
            yController: yController,
          ).inGridArea('patternSelector'),
          Wrap(
            children: [
              TileSelector(
                changeCurrentTile: changeCurrentTile,
              )
            ],
          ).inGridArea('tileSelector'),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Clear Board",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018),
                          ))),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: addPattern,
                          child: Text(
                            "Add Pattern",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018),
                          )))
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ).inGridArea('footer'),
        ],
      ),
    );
  }
}
