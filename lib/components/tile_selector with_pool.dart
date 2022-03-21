import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Function()? onAddEntry;
  Function(Tile)? removeTileFromPool;
  List<Tile> tilePool;
  List<Tile> finalTilePool;
  Tile? currentTileSelected;
  bool hasSelectedTile;
  TileSelectorWithPool(
      {Key? key,
      this.changeCurrentTile,
      this.addTileToPool,
      required this.tilePool,
      required this.currentTileSelected,
      required this.hasSelectedTile,
      required this.finalTilePool,
      this.onAddEntry,
      this.hideTileSetEntry,
      this.removeTileFromPool})
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
        .
        buttons
        ''',
      columnSizes: [1.fr],
      rowSizes: [1.2.fr, 0.05.fr, 1.fr, 0.05.fr, 0.1.fr],
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.05,
                              child: TextField(
                                controller: up,
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.008),
                                decoration: InputDecoration(
                                  labelText: 'Up',
                                  labelStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.008),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0,
                                MediaQuery.of(context).size.width * 0.006)),
                        Row(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.05,
                              child: TextField(
                                controller: left,
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.008),
                                decoration: InputDecoration(
                                  labelText: 'Left',
                                  labelStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.008),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    MediaQuery.of(context).size.width * 0.015,
                                    0)),
                            widget.hasSelectedTile
                                ? SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
                                    width: MediaQuery.of(context).size.height *
                                        0.18,
                                    child: widget.currentTileSelected,
                                  )
                                : Container(
                                    child: Center(
                                        child: Text(
                                      "Select a tile!",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.008),
                                    )),
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
                                    width: MediaQuery.of(context).size.height *
                                        0.18,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                  ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.015,
                                    0,
                                    0,
                                    0)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.05,
                              child: TextField(
                                controller: right,
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.008),
                                decoration: InputDecoration(
                                  labelText: 'Right',
                                  labelStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.008),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                0,
                                MediaQuery.of(context).size.width * 0.01,
                                0,
                                0)),
                        Row(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.05,
                              child: TextField(
                                controller: down,
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.008),
                                decoration: InputDecoration(
                                  labelText: 'Down',
                                  labelStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.008),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.009)),
                            onPressed: () {
                              if (widget.currentTileSelected!.color ==
                                  Color.fromARGB(0, 0, 0, 0)) {
                                MotionToast.error(
                                  description: Text("Please select a tile!"),
                                  animationDuration:
                                      Duration(milliseconds: 100),
                                  animationCurve: Curves.easeInOutCubic,
                                  toastDuration: Duration(milliseconds: 1500),
                                ).show(context);
                              } else {
                                Map tile = widget.currentTileSelected!.toMap();
                                Tile newTile = Tile.fromMap(tile);
                                newTile.glues = {
                                  'N': up.text,
                                  'S': down.text,
                                  'E': right.text,
                                  'W': left.text
                                };
                                newTile.showGlues = true;
                                widget.addTileToPool!(newTile);
                              }
                            },
                            child: Text("Add Tile",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.012))),
                      ],
                    )
                  ],
                ),
              ],
            ),
            //row to add tile with glues
          ]),
        ).inGridArea('tileWithGlues'),
        Center(
          child: Wrap(clipBehavior: Clip.antiAlias, children: [
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
                    Expanded(
                        child: Wrap(
                      clipBehavior: Clip.antiAlias,
                      children: [
                        TilePool(
                          mainTilePool: widget.tilePool,
                          changeTile: changeTileInPool,
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.19,
                        ),
                        TilePool(
                          mainTilePool: widget.finalTilePool,
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.19,
                          deleteTiles: true,
                          removeTile: widget.removeTileFromPool,
                        )
                      ],
                    ))
                  ],
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                )
              ],
            )
          ]),
        ).inGridArea('tileSelector'),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              child: Text(
                "Cancel Entry",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.0065),
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.009)),
              onPressed: () {
                setState(() {
                  widget.hideTileSetEntry!();
                });
              },
            )),
            Expanded(
                child: ElevatedButton(
              child: Text(
                "Add Entry",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.0065),
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.009)),
              onPressed: () {
                if (widget.finalTilePool.isEmpty) {
                  //error toast
                  MotionToast.error(
                    description: Text(
                      "You must add at least one tile!",
                    ),
                    animationDuration: Duration(milliseconds: 100),
                    animationCurve: Curves.easeInOutCubic,
                    toastDuration: Duration(milliseconds: 1500),
                  ).show(context);
                } else {
                  widget.onAddEntry != null
                      ? widget.onAddEntry!()
                      : print("no on add");
                }
              },
            ))
          ],
        ).inGridArea('buttons')
      ],
    ));
  }
}
