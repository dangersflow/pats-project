import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pats_project/components/tile.dart';

class TilePool extends StatefulWidget {
  List<Tile> mainTilePool;
  double? height;
  double? width;
  Function(int, Tile, int, int)? changeTile;
  Function(Tile)? removeTile;
  bool deleteTiles;
  TilePool(
      {Key? key,
      required this.mainTilePool,
      this.changeTile,
      this.height,
      this.width,
      this.deleteTiles = false,
      this.removeTile})
      : super(key: key);

  @override
  _TilePoolState createState() => _TilePoolState();
}

class _TilePoolState extends State<TilePool> {
  int lastSelectedTile = -1;
  int currentlySelectedTile = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height ?? MediaQuery.of(context).size.height * 0.45,
          width: widget.width ?? MediaQuery.of(context).size.width * 0.4,
          child: Card(
            child: widget.mainTilePool.isEmpty
                ? Text("Try adding a Tile!")
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                    itemCount: widget.mainTilePool.length,
                    itemBuilder: (BuildContext context, int index) {
                      return widget.deleteTiles == false
                          ? GestureDetector(
                              child: widget.mainTilePool[index],
                              onTap: () {
                                Tile currentTile = widget.mainTilePool[index];
                                Tile newTile = Tile(
                                  color: currentTile.color,
                                  showBorder: true,
                                );
                                lastSelectedTile = currentlySelectedTile;
                                currentlySelectedTile = index;
                                setState(() {
                                  widget.changeTile!(index, newTile,
                                      lastSelectedTile, currentlySelectedTile);
                                });
                              },
                            )
                          : Badge(
                              child: widget.mainTilePool[index],
                              badgeContent: GestureDetector(
                                child: Icon(
                                  Icons.remove,
                                  size:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                onTap: () {
                                  setState(() {
                                    widget.removeTile!(
                                        widget.mainTilePool[index]);
                                    print("i am here");
                                  });
                                },
                              ),
                            );
                    },
                  ),
          ),
        )
      ],
    );
  }
}
