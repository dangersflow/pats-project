import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:pats_project/components/tile.dart';
import 'package:pats_project/components/tile_pool.dart';

class TileSelector extends StatefulWidget {
  Function(Color)? changeCurrentTile;
  TileSelector({Key? key, this.changeCurrentTile}) : super(key: key);

  @override
  _TileSelectorState createState() => _TileSelectorState();
}

class _TileSelectorState extends State<TileSelector> {
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  TextEditingController textController = TextEditingController();
  List<Tile> tilePool = [];

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void changeTileInPool(
      int index, Tile tile, int lastSelectedTile, int currentlySelectedTile) {
    if (lastSelectedTile != -1) {
      setState(() {
        Tile currentTile = tilePool[lastSelectedTile];
        Tile newTile = Tile(color: currentTile.color, showBorder: false);
        //tilePool[lastSelectedTile].showBorder = false;
        tilePool[lastSelectedTile] = newTile;
        print(tilePool[lastSelectedTile].toStringValue());
      });
    }
    setState(() {
      print(index.toString() + tile.toStringValue());
      tilePool[index] = tile;
      widget.changeCurrentTile!(tile.color);
    });
  }

  bool tileExists(Tile tile) {
    for (Tile x in tilePool) {
      if (x.color == tile.color) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Column(
            children: [
              //Tile(color: pickerColor, x: 250, y: 250),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  child: LayoutGrid(
                    areas: '''
                    colorPicker
                    colorPicker
                    colorPicker
                    button        
                    ''',
                    columnSizes: [1.fr],
                    rowSizes: [1.fr, 1.fr, 1.fr, 0.7.fr],
                    children: [
                      ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: changeColor,
                        hexInputBar: true,
                        hexInputController: textController,
                      ).inGridArea('colorPicker'),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Tile newTile = Tile(color: pickerColor);
                                if (!tileExists(newTile)) {
                                  setState(() {
                                    tilePool.add(Tile(
                                      color: pickerColor,
                                    ));
                                  });
                                } else {
                                  MotionToast.error(
                                    description: Text("Tile Already Exists!"),
                                    animationDuration:
                                        Duration(milliseconds: 100),
                                    animationCurve: Curves.easeInOutCubic,
                                    toastDuration: Duration(milliseconds: 1000),
                                  ).show(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: BeveledRectangleBorder()),
                              child: Text(
                                "Add",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018),
                              ),
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                      ).inGridArea('button'),
                    ],
                  ),
                ),
              ),
              TilePool(
                mainTilePool: tilePool,
                changeTile: changeTileInPool,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
