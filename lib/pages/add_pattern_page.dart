import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:go_router/go_router.dart';
import 'package:pats_project/components/pattern_selector.dart';
import 'package:pats_project/components/tile.dart';
import 'package:pats_project/components/tile_selector.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:screenshot/screenshot.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddPatternPage extends StatefulWidget {
  const AddPatternPage({Key? key}) : super(key: key);

  @override
  _AddPatternPageState createState() => _AddPatternPageState();
}

class _AddPatternPageState extends State<AddPatternPage> {
  List<Tile> tilePool = [];
  List<Tile> grid = [];
  List<Map> gridMap = [];
  List<Map> tilePoolMap = [];
  Tile currentlySelectedTile = Tile(color: Colors.black);
  bool hasATileSelected = false;
  bool enabledPainting = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController xController = TextEditingController();
  TextEditingController yController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  void changeCurrentTile(Color color) {
    setState(() {
      currentlySelectedTile = Tile(color: color);
      hasATileSelected = true;
    });
  }

  void addTileToPool(Tile tile) {
    setState(() {
      tilePoolMap.add({'color': tile.color.value});
    });
    print("tile added!");
  }

  Future<void> convertGridToMap() async {
    for (int i = 0; i < grid.length; i++) {
      gridMap.add(grid[i].toMap());
    }
  }

  Future<void> convertTilePoolToMap() async {
    for (int i = 0; i < tilePool.length; i++) {
      tilePoolMap.add(tilePool[i].toMap());
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
    CollectionReference patterns_home =
        FirebaseFirestore.instance.collection('patterns_homepage');
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    String currentImageKey = '';
    String currentImageUrl = '';

    Uint8List _image;
    //generate random string name
    String randomString(int length) {
      var rand = new Random();
      var codeUnits = new List.generate(length, (index) {
        return rand.nextInt(33) + 89;
      });
      return new String.fromCharCodes(codeUnits);
    }

    Future<void> uploadImageToStorage(Uint8List image) async {
      try {
        currentImageKey = randomString(10) + '.png';
        await storage
            .ref()
            .child(currentImageKey)
            .putData(image)
            .then((p0) async {
          String imageUrl = await p0.ref.getDownloadURL();
          currentImageUrl = imageUrl;
          print(imageUrl);
        });
      } on firebase_core.FirebaseException catch (e) {
        print(e);
      }
    }

    Future<void> addPattern() async {
      //screenshot our grid
      await screenshotController.capture().then((image) async {
        await uploadImageToStorage(image!);
        //display the image in an alert dialog
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text('Pattern Image'),
        //       content: Image.memory(image),
        //     );
        //   },
        // );
        context.go('/');
      });
      //convert current grid to map
      await convertGridToMap();
      // Call the user's CollectionReference to add a new user
      patterns_home.add({
        'image': currentImageUrl,
        'name': nameController.text,
        'project_name': nameController.text,
      });
      patterns.add({
        'keyPattern': nameController.text, // John Doe// 42
        'pattern_dimension_x': int.parse(xController.text),
        'pattern_dimension_y': int.parse(xController.text),
        'leaderboard': [],
        'tilePool': tilePoolMap,
        'grid': gridMap
      }).then((value) {
        print("Pattern Added");
        MotionToast.success(
          description: Text("Pattern Added Successfully!"),
          animationDuration: Duration(milliseconds: 100),
          animationCurve: Curves.easeInOutCubic,
          toastDuration: Duration(milliseconds: 1000),
        ).show(context);
        //clear our tile pool
        tilePoolMap.clear();
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
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              addPattern();
            },
          ),
          //icon button to clear board
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                grid = [];
                for (int i = 0;
                    i <
                        int.parse(xController.text) *
                            int.parse(yController.text);
                    i++) {
                  grid.add(Tile(
                    color: Colors.grey,
                    id: i + 1,
                  ));
                }
              });
            },
          ),
        ],
      ),
      body: LayoutGrid(
        areas: '''
        . .               .               .         .            .                .
        . header          .               settings  .            .                .
        . patternSelector patternSelector settings  tileSelector tileSelector     .
        . footer          footer          settings  .            .                .
        ''',
        columnSizes: [0.25.fr, 1.0.fr, 0.2.fr, 0.15.fr, 0.7.fr, 1.fr, 0.2.fr],
        rowSizes: [0.05.fr, 0.10.fr, 1.fr, 0.1.fr],
        children: [
          Column(
            children: [
              Switch(
                  value: enabledPainting,
                  onChanged: (value) {
                    setState(() {
                      enabledPainting = value;
                    });
                  })
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ).inGridArea('settings'),
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
            screenshotController: screenshotController,
            hasATileSelected: hasATileSelected,
            enabledPainting: enabledPainting,
          ).inGridArea('patternSelector'),
          Wrap(
            children: [
              TileSelector(
                changeCurrentTile: changeCurrentTile,
                addTileToPool: addTileToPool,
              )
            ],
          ).inGridArea('tileSelector'),
        ],
      ),
    );
  }
}
