import 'package:flutter/material.dart';
import 'package:pats_project/components/leaderboard.dart';
import 'package:pats_project/components/pattern_display.dart';
import 'package:pats_project/components/tile_set_entry.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:go_router/go_router.dart';

class ViewPatternPage extends StatefulWidget {
  bool isTileEntryVisible;
  ViewPatternPage({Key? key, this.isTileEntryVisible = false})
      : super(key: key);

  @override
  _ViewPatternPageState createState() => _ViewPatternPageState();
}

class _ViewPatternPageState extends State<ViewPatternPage> {
  List<Map> exampleData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void showTileSetEntry() {
    setState(() {
      widget.isTileEntryVisible = true;
    });
  }

  void hideTileSetEntry() {
    setState(() {
      widget.isTileEntryVisible = false;
    });
  }

  void updateData(List<Map> data) {
    setState(() {
      exampleData = data;
      exampleData
          .sort((a, b) => (a['tileSet'].length).compareTo(b['tileSet'].length));
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
         . .             .             . .            .
         . patternHeader patternHeader . .            .
         . pattern       pattern       . leaderboard  .
         . pattern       pattern       . leaderboard  .
         . footer        footer        . .            .
        ''',
          columnSizes: [0.2.fr, 1.fr, auto, auto, 1.fr, 0.2.fr],
          rowSizes: [
            40.px,
            100.px,
            1.fr,
            auto,
            100.px,
          ],
          // Column and row gaps! 🔥
          columnGap: 12,
          rowGap: 12,
          children: [
            Text(
              'Square',
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width / 50),
            ).inGridArea('patternHeader'),
            SizedBox(
              child: PatternDisplay(
                x: 5,
                y: 5,
              ),
              width: MediaQuery.of(context).size.width / 3,
            ).inGridArea('pattern'),
            widget.isTileEntryVisible
                ? TileSetEntry(
                    hideTileSetEntry: hideTileSetEntry,
                    exampleData: exampleData,
                    updateData: updateData,
                  ).inGridArea('leaderboard')
                : Leaderboard(
                    listData: exampleData,
                    onAddEntry: showTileSetEntry,
                  ).inGridArea('leaderboard'),
          ],
        )
        // Center(
        //   child: Column(
        //     children: [
        //       Row(children: [
        //         const Padding(padding: EdgeInsets.fromLTRB(100, 150, 0, 0)),
        //         Text(
        //           'Demo Pattern',
        //           style:
        //               TextStyle(fontSize: MediaQuery.of(context).size.width / 50),
        //         ),
        //       ]),
        //       Row(
        //         children: [
        //           SizedBox(
        //               child: PatternDisplay(x: 5, y: 5),
        //               width: MediaQuery.of(context).size.width / 3,
        //               height: MediaQuery.of(context).size.width / 3),
        //           const Padding(padding: EdgeInsets.fromLTRB(150, 0, 0, 0)),
        //           widget.isTileEntryVisible
        //               ? SizedBox(
        //                   child: TileSetEntry(
        //                     hideTileSetEntry: hideTileSetEntry,
        //                     exampleData: exampleData,
        //                     updateData: updateData,
        //                   ),
        //                   width: MediaQuery.of(context).size.width / 3,
        //                   height: MediaQuery.of(context).size.width / 3)
        //               : SizedBox(
        //                   child: Leaderboard(
        //                     listData: exampleData,
        //                     onAddEntry: showTileSetEntry,
        //                   ),
        //                   width: MediaQuery.of(context).size.width / 3,
        //                   height: MediaQuery.of(context).size.width / 3,
        //                 ),
        //         ],
        //         mainAxisAlignment: MainAxisAlignment.center,
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
