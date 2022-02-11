import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:pats_project/components/tile.dart';
import 'package:pats_project/components/tile_pool.dart';

class TileSelectorWithPool extends StatefulWidget {
  Function(Color)? changeCurrentTile;
  Function(Tile)? addTileToPool;
  Function()? hideTileSetEntry;
  List<Tile> tilePool;
  Tile currentTileSelected;
  bool hasSelectedTile;
  TileSelectorWithPool(
      {Key? key,
      this.changeCurrentTile,
      this.addTileToPool,
      required this.tilePool,
      required this.currentTileSelected,
      required this.hasSelectedTile,
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
        tileSelector
        buttons
        ''',
      columnSizes: [1.fr],
      rowSizes: [0.5.fr, 1.fr, 0.1.fr],
      children: [
        LayoutGrid(
          areas: '''
                  .    up    .
                left  tile right
                  .   down   .
                ''',
          columnSizes: [1.fr, 1.fr, 1.fr],
          rowSizes: [1.fr, 1.fr, 1.fr],
          children: [
            widget.hasSelectedTile
                ? Center(child: widget.currentTileSelected).inGridArea('tile')
                : Container().inGridArea('tile'),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.025,
                child: TextField(
                    controller: up,
                    maxLength: 1,
                    decoration: InputDecoration(
                        label: Text("N"),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 5.0),
                        ))),
              ),
            ).inGridArea('up'),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.025,
                child: TextField(
                    controller: down,
                    maxLength: 1,
                    decoration: InputDecoration(
                        label: Text("S"),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 5.0),
                        ))),
              ),
            ).inGridArea('down'),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.025,
                  child: TextField(
                      controller: left,
                      maxLength: 1,
                      decoration: InputDecoration(
                          label: Text("W"),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 5.0),
                          ))),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ).inGridArea('left'),
            Row(children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.025,
                  child: TextField(
                      controller: right,
                      maxLength: 1,
                      decoration: InputDecoration(
                          label: Text("E"),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 5.0),
                          ))),
                ),
              ),
            ]).inGridArea('right')
          ],
        ).inGridArea('tileWithGlues'),
        TilePool(
          mainTilePool: widget.tilePool,
          changeTile: changeTileInPool,
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
        )
      ],
    ));
  }
}
