import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pats_project/components/pats_simulation.dart';
import 'package:pats_project/components/pattern_display.dart';
import 'package:pats_project/components/tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PATSSimulationWidget extends StatefulWidget {
  List<Tile> grid;
  List<Tile> bottomGlueRow;
  List<Tile> leftGlueColumn;
  List<Tile> tilePool;
  int x;
  int y;
  PATSSimulationWidget(
      {Key? key,
      required this.grid,
      required this.bottomGlueRow,
      required this.leftGlueColumn,
      required this.tilePool,
      required this.x,
      required this.y})
      : super(key: key);

  @override
  _PATSSimulationWidgetState createState() => _PATSSimulationWidgetState();
}

class _PATSSimulationWidgetState extends State<PATSSimulationWidget> {
  List<Tile> resultingGrid = [];
  List<Map> gridMap = [];

  List<Map> convertGridToMap(List<Tile> grid) {
    List<Map> tempList = [];

    for (int i = 0; i < grid.length; i++) {
      tempList.add(grid[i].toMap());
    }

    return tempList;
  }

  List<Tile> TileGridToTransparentTileGrid(List<Tile> grid) {
    List<Tile> temp = [];

    for (int i = 0; i < grid.length; i++) {
      //set current tile transparency
      Tile currentTile = grid[i];
      currentTile.color = currentTile.color.withOpacity(0.5);
      temp.add(currentTile);
    }

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    PATSSimulation mainSimulation = PATSSimulation(
        x: widget.x,
        y: widget.y,
        mainGrid: widget.grid,
        leftGlueColumn: widget.leftGlueColumn,
        bottomGlueRow: widget.bottomGlueRow,
        resultingGrid: resultingGrid);
    List<Tile> transparancyGrid = TileGridToTransparentTileGrid(widget.grid);
    gridMap = convertGridToMap(transparancyGrid);

    return LayoutGrid(
      areas: '''
      .       .       .         .       .     .
      .       pattern pattern   .       bag   .
      .       pattern pattern   .       bag   .
      .       .       .         .       .     .
      ''',
      columnSizes: [0.5.fr, 1.fr, 1.fr, 1.fr, 1.fr, 0.5.fr],
      rowSizes: [0.2.fr, 1.fr, 1.fr, 0.2.fr],
      children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: PatternDisplay(
              x: widget.x,
              y: widget.y,
              grid: gridMap,
              col: widget.leftGlueColumn,
              row: widget.bottomGlueRow,
            ),
          ),
        ).inGridArea('pattern'),
      ],
    );
  }
}
