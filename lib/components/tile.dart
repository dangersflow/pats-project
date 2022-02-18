import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  final Color color;
  final Map? glues;
  final double x, y;
  int id;
  bool showGlues;
  bool showBorder;

  Tile(
      {Key? key,
      required this.color,
      this.glues,
      this.x = 100,
      this.y = 100,
      this.id = 0,
      this.showGlues = false,
      this.showBorder = false})
      : super(key: key);

  Map toMap() {
    return {
      'color': color.value,
      'glues': glues,
      'x': x,
      'y': y,
      'id': id,
      'showGlues': showGlues,
      'showBorder': showBorder
    };
  }

  String toStringValue() {
    return {
      'color': color.value,
      'glues': glues,
      'x': x,
      'y': y,
      'id': id,
      'showGlues': showGlues,
      'showBorder': showBorder
    }.toString();
  }

  void setShowBorder(bool value) {
    showBorder = value;
  }

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.x,
      height: widget.y,
      decoration: widget.showBorder == true
          ? BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              color: widget.color)
          : BoxDecoration(color: widget.color),
      child: widget.showGlues
          ? Column(
              children: [
                //top
                Row(
                  children: const [Text("X")],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                //middle
                Row(
                  children: [
                    const Text("X"),
                    Text(widget.id.toString()),
                    const Text("X")
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                //bottom
                Row(
                  children: const [Text("X")],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            )
          : Container(),
    );
  }
}
