import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pats_project/components/tile.dart';

class PatternDisplay extends StatefulWidget {
  final int x, y;
  List<Map>? grid;
  List<Tile>? col;
  List<Tile>? row;
  bool doAnim;
  PatternDisplay(
      {Key? key,
      required this.x,
      required this.y,
      this.grid,
      this.col,
      this.row,
      this.doAnim = false})
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
    int colCounter = -1;
    int rowCounter = -1;
    int gridCounter = -1;
    bool cornerTile = false;
    int totalTime = 1500;
    double increments = (totalTime / widget.x);
    double colDelay = 0;
    double rowDelay = 0;
    int currentDelay = 250;
    return widget.grid!.isEmpty
        ? Container()
        : GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: (widget.x + 1) * (widget.y + 1),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisCount: widget.x + 1,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            reverse: true,
            itemBuilder: (context, index) {
              colDelay += increments / 9;
              //column
              if (index % (widget.x + 1) == 0) {
                colCounter++;
                if (colCounter == 0 && cornerTile == false) {
                  colCounter = -1;
                  cornerTile = true;
                  return Tile(
                    color: Colors.transparent,
                  );
                } else {
                  return FadeInLeft(
                      delay: Duration(milliseconds: colDelay.toInt()),
                      child: widget.col![colCounter]);
                }
              }
              //row
              else if (index < widget.x + 1) {
                rowCounter++;
                rowDelay += increments;

                return FadeInUp(
                    delay: Duration(milliseconds: rowDelay.toInt()),
                    child: widget.row![rowCounter]);
              } else {
                gridCounter++;
                return widget.doAnim == false
                    ? Tile(
                        x: widget.grid![gridCounter]['x'],
                        y: widget.grid![gridCounter]['y'],
                        id: widget.grid![gridCounter]['id'],
                        glues: widget.grid![gridCounter]['glues'],
                        showGlues: widget.grid![gridCounter]['showGlues'],
                        showBorder: widget.grid![gridCounter]['showBorder'],
                        color: Color(widget.grid![gridCounter]['color']),
                      )
                    : FadeInRight(
                        delay: Duration(milliseconds: currentDelay += 250),
                        child: Tile(
                          x: widget.grid![gridCounter]['x'],
                          y: widget.grid![gridCounter]['y'],
                          id: widget.grid![gridCounter]['id'],
                          glues: widget.grid![gridCounter]['glues'],
                          showGlues: widget.grid![gridCounter]['showGlues'],
                          showBorder: widget.grid![gridCounter]['showBorder'],
                          color: Color(widget.grid![gridCounter]['color']),
                        ));
              }
            },
          );
  }
}
