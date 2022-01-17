import 'package:flutter/material.dart';
import 'package:pats_project/components/tile.dart';

class PatternDisplay extends StatefulWidget {
  final int x, y;
  PatternDisplay({Key? key, required this.x, required this.y})
      : super(key: key);

  @override
  _PatternDisplayState createState() => _PatternDisplayState();
}

class _PatternDisplayState extends State<PatternDisplay> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.x * widget.y,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.x,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        if (index % widget.x == 0 || index > (widget.x * (widget.y - 1))) {
          return Tile(
            x: 100,
            y: 100,
            id: index,
            color: "0xFF9A031E",
          );
        } else {
          return Tile(
            x: 100,
            y: 100,
            id: index,
            color: "0xFF7CDEDC",
          );
        }
      },
    );
  }
}
