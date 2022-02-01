import 'package:flutter/material.dart';
import 'package:pats_project/components/tile.dart';

class TilePool extends StatefulWidget {
  List<Tile> mainTilePool;
  Function(int, Tile, int?)? changeTile;
  TilePool({Key? key, required this.mainTilePool, this.changeTile})
      : super(key: key);

  @override
  _TilePoolState createState() => _TilePoolState();
}

class _TilePoolState extends State<TilePool> {
  int lastSelectedTile = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width * 0.4,
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
                      return GestureDetector(
                        child: widget.mainTilePool[index],
                        onTap: () {
                          Tile currentTile = widget.mainTilePool[index];
                          Tile newTile = Tile(
                            color: currentTile.color,
                            showBorder: true,
                          );
                          lastSelectedTile = index;
                          setState(() {
                            widget.changeTile!(
                                index, newTile, lastSelectedTile);
                          });
                        },
                      );
                    },
                  ),
          ),
        )
      ],
    );
  }
}
