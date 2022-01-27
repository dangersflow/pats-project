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
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.x * widget.y,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisCount: widget.x,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      reverse: true,
      itemBuilder: (context, index) {
        return Tile(
          x: 100,
          y: 100,
          id: index + 1,
          color: Color(0xFF7CDEDC),
        );
      },
    );
  }
}
