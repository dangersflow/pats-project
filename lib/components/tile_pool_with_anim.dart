import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pats_project/components/tile.dart';

class TilePoolWithAnim extends StatefulWidget {
  List<Tile> mainTilePool;
  double? height;
  double? width;
  Function(int, Tile, int, int)? changeTile;
  TilePoolWithAnim(
      {Key? key,
      required this.mainTilePool,
      this.changeTile,
      this.height,
      this.width})
      : super(key: key);

  @override
  _TilePoolWithAnimState createState() => _TilePoolWithAnimState();
}

class _TilePoolWithAnimState extends State<TilePoolWithAnim> {
  int lastSelectedTile = -1;
  int currentlySelectedTile = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? MediaQuery.of(context).size.height * 0.45,
      width: widget.width ?? MediaQuery.of(context).size.width * 0.4,
      child: Card(
        child: widget.mainTilePool.isEmpty
            ? Text("Try adding a Tile!")
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemCount: widget.mainTilePool.length,
                itemBuilder: (BuildContext context, int index) {
                  return FadeInDown(
                    child: widget.mainTilePool[index],
                    duration: Duration(milliseconds: 100),
                  );
                },
              ),
      ),
    );
  }
}
