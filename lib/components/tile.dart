import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  Color color;
  Map? glues;
  double x, y;
  int id;
  bool showGlues;
  bool showBorder;
  bool showIndex;

  Tile(
      {Key? key,
      required this.color,
      this.glues,
      this.x = 100,
      this.y = 100,
      this.id = 0,
      this.showGlues = false,
      this.showBorder = false,
      this.showIndex = false})
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

  //generate fromMap function
  factory Tile.fromMap(Map map) {
    return Tile(
      color: Color(map['color']),
      glues: map['glues'],
      x: map['x'],
      y: map['y'],
      id: map['id'],
      showGlues: map['showGlues'],
      showBorder: map['showBorder'],
    );
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
      child: widget.showGlues && widget.glues != null
          ? Column(
              children: [
                //top
                Row(
                  children: [
                    Text(
                      widget.glues!['N'] ?? '',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.01,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                //middle
                Row(
                  children: [
                    Text(widget.glues?['W'] ?? '',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.01,
                            fontWeight: FontWeight.bold)),
                    Text(widget.showIndex ? widget.id.toString() : '',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.01,
                            fontWeight: FontWeight.bold)),
                    Text(widget.glues?['E'] ?? '',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.01,
                            fontWeight: FontWeight.bold))
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                //bottom
                Row(
                  children: [
                    Text(widget.glues?['S'] ?? '',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.01,
                            fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            )
          : Container(),
    );
  }
}
