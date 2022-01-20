import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pats_project/components/tile_container.dart';

class TileSetEntry extends StatefulWidget {
  List<Map> exampleData;
  Function(List<Map>) updateData;
  Function() hideTileSetEntry;
  TileSetEntry(
      {Key? key,
      required this.hideTileSetEntry,
      required this.exampleData,
      required this.updateData})
      : super(key: key);

  @override
  _TileSetEntryState createState() => _TileSetEntryState();
}

class _TileSetEntryState extends State<TileSetEntry> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Tile Set Entry",
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.01,
              fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
        TextField(
          decoration:
              InputDecoration(alignLabelWithHint: true, label: Text("Name")),
          onChanged: (value) {},
        ),
        TileContainer(),
        Row(
          children: [
            ElevatedButton(
              child: Text("Cancel New Entry"),
              onPressed: widget.hideTileSetEntry,
            ),
            ElevatedButton(
              child: Text("Add New Entry"),
              onPressed: () {
                widget.exampleData.add({
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
                widget.updateData(widget.exampleData);
                widget.hideTileSetEntry();
              },
            )
          ],
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
