import 'package:flutter/material.dart';
import 'package:pats_project/components/tile_container.dart';

class LeaderboardTile extends StatefulWidget {
  int index;
  String name;
  var tiles;
  LeaderboardTile(
      {Key? key, required this.index, required this.name, required this.tiles})
      : super(key: key);

  @override
  _LeaderboardTileState createState() => _LeaderboardTileState();
}

class _LeaderboardTileState extends State<LeaderboardTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.index.toString() + ".",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.015),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                Text(widget.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.015))
              ],
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0)),
                Text(
                  "This user made the pattern in " +
                      widget.tiles.length.toString() +
                      " tile/s.",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
