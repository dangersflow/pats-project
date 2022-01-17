import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  final String color;
  final Map? glues;
  final double x, y;
  int id;

  Tile(
      {Key? key,
      required this.color,
      this.glues,
      this.x = 100,
      this.y = 100,
      required this.id})
      : super(key: key);

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(int.parse(widget.color)),
      width: widget.x,
      height: widget.y,
      child: Column(
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
      ),
    );
  }
}
