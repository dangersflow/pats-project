import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pats_project/components/tile.dart';
import 'package:pats_project/components/tile_container.dart';

class TileSetEntry extends StatefulWidget {
  List<Map> leaderboardData;
  List<Tile> tilePool;
  Function(List<Map>) updateData;
  Function() hideTileSetEntry;
  TileSetEntry(
      {Key? key,
      required this.hideTileSetEntry,
      required this.leaderboardData,
      required this.tilePool,
      required this.updateData})
      : super(key: key);

  @override
  _TileSetEntryState createState() => _TileSetEntryState();
}

class _TileSetEntryState extends State<TileSetEntry> {
  @override
  Widget build(BuildContext context) {
    return LayoutGrid(
      areas: '''
      title
      namefield
      tilepool
      buttons
      ''',
      columnSizes: [1.fr],
      rowSizes: [0.1.fr, 1.fr, 1.fr, 1.fr],
      children: [
        Text(
          "Tile Set Entry",
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.01,
              fontWeight: FontWeight.bold),
        ).inGridArea('title'),
        TextField(
          decoration:
              InputDecoration(alignLabelWithHint: true, label: Text("Name")),
          onChanged: (value) {},
        ).inGridArea('namefield'),
        TileContainer().inGridArea('tilepool'),
        Row(
          children: [
            ElevatedButton(
              child: Text("Cancel New Entry"),
              onPressed: widget.hideTileSetEntry,
            ),
            ElevatedButton(
              child: Text("Add New Entry"),
              onPressed: () {
                widget.leaderboardData.add({
                  'user': 'Example',
                  'image': 'https://randomuser.me/api/portraits/',
                  'tileSet': {
                    {
                      'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
                      'color': '0xFF9A031E',
                      'id': 1
                    },
                  },
                });
                widget.updateData(widget.leaderboardData);
                widget.hideTileSetEntry();
              },
            )
          ],
        ).inGridArea('buttons'),
      ],
    );
  }
}
