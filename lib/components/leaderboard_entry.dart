import 'package:flutter/material.dart';
import 'package:pats_project/components/tile_container.dart';

class LeaderboardEntry extends StatefulWidget {
  List<Map> listData;
  LeaderboardEntry({Key? key, required this.listData}) : super(key: key);

  @override
  _LeaderboardEntryState createState() => _LeaderboardEntryState();
}

class _LeaderboardEntryState extends State<LeaderboardEntry> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "New Entry",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          TextField(
            autofocus: true,
            decoration: const InputDecoration(
              labelText: "Name",
            ),
            onSubmitted: (value) {
              setState(() {
                widget.listData.add({
                  'user': value,
                  'tileSet': {'L': 0, 'R': 0, 'U': 0, 'D': 0},
                });
                widget.listData.sort((a, b) =>
                    (a['tileSet'].length).compareTo(b['tileSet'].length));
              });
              Navigator.of(context).pop();
            },
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
          const Text("Enter your tiles down below:"),
          const TileContainer()
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      actions: [
        TextButton(
          child: const Text("Submit"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
