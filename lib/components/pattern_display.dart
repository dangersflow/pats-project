import 'package:flutter/material.dart';
import 'package:pats_project/components/tile.dart';

class PatternDisplay extends StatefulWidget {
  final int x, y;
  List<Map>? grid;
  PatternDisplay({Key? key, required this.x, required this.y, this.grid})
      : super(key: key);

  @override
  _PatternDisplayState createState() => _PatternDisplayState();
}

class _PatternDisplayState extends State<PatternDisplay> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.grid!);
  }

  @override
  Widget build(BuildContext context) {
    return widget.grid!.isEmpty
        ? CircularProgressIndicator()
        : GridView.builder(
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
                x: widget.grid![index]['x'],
                y: widget.grid![index]['y'],
                id: widget.grid![index]['id'],
                color: Color(widget.grid![index]['color']),
              );
            },
          );
  }
}
