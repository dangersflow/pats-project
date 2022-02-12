import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:pats_project/components/expandable_card.dart';
import 'package:pats_project/components/tile.dart';
import 'package:pats_project/components/tile_pool.dart';

class TileSelectorWithPool extends StatefulWidget {
  Function(Color)? changeCurrentTile;
  Function(Tile)? addTileToPool;
  Function()? hideTileSetEntry;
  List<Tile> tilePool;
  List<Tile> finalTilePool;
  Tile currentTileSelected;
  bool hasSelectedTile;
  TileSelectorWithPool(
      {Key? key,
      this.changeCurrentTile,
      this.addTileToPool,
      required this.tilePool,
      required this.currentTileSelected,
      required this.hasSelectedTile,
      required this.finalTilePool,
      this.hideTileSetEntry})
      : super(key: key);

  @override
  _TileSelectorWithPoolState createState() => _TileSelectorWithPoolState();
}

class _TileSelectorWithPoolState extends State<TileSelectorWithPool> {
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  TextEditingController up = TextEditingController();
  TextEditingController down = TextEditingController();
  TextEditingController left = TextEditingController();
  TextEditingController right = TextEditingController();

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void changeTileInPool(
      int index, Tile tile, int lastSelectedTile, int currentlySelectedTile) {
    if (lastSelectedTile != -1) {
      setState(() {
        Tile currentTile = widget.tilePool[lastSelectedTile];
        Tile newTile = Tile(color: currentTile.color, showBorder: false);
        //tilePool[lastSelectedTile].showBorder = false;
        widget.tilePool[lastSelectedTile] = newTile;
        print(widget.tilePool[lastSelectedTile].toStringValue());
      });
    }
    setState(() {
      print(index.toString() + tile.toStringValue());
      widget.tilePool[index] = tile;
      widget.changeCurrentTile!(tile.color);
    });
  }

  bool tileExists(Tile tile) {
    for (Tile x in widget.tilePool) {
      if (x.color == tile.color) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LayoutGrid(
      areas: '''
        tileWithGlues
        .
        tileSelector
        buttons
        ''',
      columnSizes: [1.fr],
      rowSizes: [0.8.fr, 0.1.fr, 1.fr, 0.05.fr],
      children: [
        Center(
          child: Wrap(clipBehavior: Clip.antiAlias, children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Add Glues",
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.height +
                                  MediaQuery.of(context).size.width) *
                              0.006),
                    )
                  ],
                ),
                Divider(endIndent: MediaQuery.of(context).size.width * 0.3),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                      child: TextField(
                        controller: up,
                        decoration: InputDecoration(
                          labelText: 'Up',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                      child: TextField(
                        controller: left,
                        decoration: InputDecoration(
                          labelText: 'Left',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 30, 0)),
                    widget.hasSelectedTile
                        ? SizedBox(
                            height: 200,
                            width: 200,
                            child: widget.currentTileSelected,
                          )
                        : Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                          ),
                    Padding(padding: EdgeInsets.fromLTRB(30, 0, 0, 0)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                      child: TextField(
                        controller: right,
                        decoration: InputDecoration(
                          labelText: 'Right',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                      child: TextField(
                        controller: down,
                        decoration: InputDecoration(
                          labelText: 'Down',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )
          ]),
        ).inGridArea('tileWithGlues'),
        Center(
          child: Wrap(children: [
            Column(
              children: [
                Row(
                  children: [
                    Text("Select Tile",
                        style: TextStyle(
                            fontSize: (MediaQuery.of(context).size.height +
                                    MediaQuery.of(context).size.width) *
                                0.006)),
                  ],
                ),
                Divider(endIndent: MediaQuery.of(context).size.width * 0.3),
                Row(
                  children: [
                    TilePool(
                      mainTilePool: widget.tilePool,
                      changeTile: changeTileInPool,
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    TilePool(
                      mainTilePool: widget.finalTilePool,
                      changeTile: changeTileInPool,
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                  ],
                )
              ],
            )
          ]),
        ).inGridArea('tileSelector'),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              child: Text("Cancel Entry"),
              onPressed: () {
                setState(() {
                  widget.hideTileSetEntry!();
                });
              },
            )),
            Expanded(
                child: ElevatedButton(
              child: Text("Add Entry"),
              onPressed: () {},
            ))
          ],
        ).inGridArea('buttons')
      ],
    ));
  }
}