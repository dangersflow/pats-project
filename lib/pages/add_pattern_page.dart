import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:go_router/go_router.dart';
import 'package:pats_project/components/pattern_selector.dart';
import 'package:pats_project/components/tile.dart';
import 'package:pats_project/components/tile_selector.dart';

class AddPatternPage extends StatefulWidget {
  const AddPatternPage({Key? key}) : super(key: key);

  @override
  _AddPatternPageState createState() => _AddPatternPageState();
}

class _AddPatternPageState extends State<AddPatternPage> {
  List<Tile> tilePool = [];
  Tile currentlySelectedTile = Tile(color: Colors.black);

  void changeCurrentTile(Tile tile) {
    setState(() {
      currentlySelectedTile = tile;
    });
  }

  void addTileToPool(Tile tile) {
    setState(() {
      tilePool.add(tile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Text("PATS PROJECT"),
          onTap: () {
            context.go('/');
          },
          splashColor: Colors.transparent,
          enableFeedback: false,
          splashFactory: NoSplash.splashFactory,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
      body: LayoutGrid(
        areas: '''
        . .               . .            .                .
        . header          . .            .                .
        . patternSelector . tileSelector tileSelector     .
        . footer          . .            .                .
        ''',
        columnSizes: [0.25.fr, 0.9.fr, 0.2.fr, 0.5.fr, 1.fr, 0.2.fr],
        rowSizes: [0.05.fr, 0.15.fr, 1.fr, 0.2.fr],
        children: [
          Text(
            "Add a New Pattern",
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.02),
          ).inGridArea('header'),
          PatternSelector(
            currentlySelectedTile: currentlySelectedTile,
          ).inGridArea('patternSelector'),
          TileSelector(
            changeCurrentTile: changeCurrentTile,
          ).inGridArea('tileSelector'),
        ],
      ),
    );
  }
}
