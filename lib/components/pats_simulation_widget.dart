import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pats_project/components/pats_simulation.dart';
import 'package:pats_project/components/pattern_display.dart';
import 'package:pats_project/components/tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pats_project/components/tile_pool_with_anim.dart';

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
  List<Map> resultingGridMap = [];
  List<Tile> transparancyGrid = [];
  bool performAnimation = false;
  bool verification = false;
  bool isSimulating = false;
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

  void setResultingGrid(List<Tile> grid) {
    setState(() {
      resultingGrid = grid;
      resultingGridMap = convertGridToMap(grid);
      print("here I am :)");
      print("wpw");
      print(resultingGridMap);
    });

    setState(() {
      performAnimation = true;
      gridMap = resultingGridMap;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<Tile> transparancyGrid = TileGridToTransparentTileGrid(widget.grid);
    gridMap = convertGridToMap(transparancyGrid);
  }

  //check if the resulting grid and the grid are the same
  bool checkIfSame(List<Map> grid1, List<Map> grid2) {
    if (grid1.length != grid2.length) {
      return false;
    }

    for (int i = 0; i < grid1.length; i++) {
      if (grid1[i]['color'] != grid2[i]['color']) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    PATSSimulation mainSimulation = PATSSimulation(
        x: widget.x,
        y: widget.y,
        mainGrid: widget.grid,
        leftGlueColumn: widget.leftGlueColumn,
        bottomGlueRow: widget.bottomGlueRow,
        resultingGrid: resultingGrid,
        tilePool: widget.tilePool,
        setResultingGrid: setResultingGrid);

    return Stack(
      children: [
        LayoutGrid(
          areas: '''
      .       .       .         .       .      .
      .       pattern pattern   bag     bag    .
      .       pattern pattern   bag     bag    .
      .       .       .         button  button .
      ''',
          columnSizes: [0.1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 0.2.fr],
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
                  doAnim: performAnimation,
                ),
              ),
            ).inGridArea('pattern'),
            Center(child: TilePoolWithAnim(mainTilePool: widget.tilePool))
                .inGridArea('bag'),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      mainSimulation.simulate();
                      setResultingGrid(mainSimulation.resultingGrid);
                    },
                    child: Text("Start Simulation!")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        verification = checkIfSame(resultingGridMap, gridMap);
                        isSimulating = false;
                      });
                    },
                    child: Text("Verify"))
              ],
            ).inGridArea('button')
          ],
        ),
        !isSimulating && verification
            ? Center(
                child: ZoomIn(
                  child: Icon(
                    Icons.verified,
                    size: MediaQuery.of(context).size.width * 0.2,
                  ),
                  animate: verification,
                ),
              )
            : Container(),
      ],
    );
  }
}
