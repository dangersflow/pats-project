import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pats_project/components/leaderboard_tile.dart';
import 'package:pats_project/components/tile_container.dart';

class Leaderboard extends StatefulWidget {
  List<Map> listData;
  Function() onAddEntry;
  Leaderboard({Key? key, required this.listData, required this.onAddEntry})
      : super(key: key);

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  void initState() {
    //implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutGrid(
      areas: '''
      leaderboard
      leaderboard
      leaderboard
      leaderboard
      leaderboard
      button
      ''',
      columnSizes: [1.fr],
      rowSizes: [1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 1.fr],
      children: [
        widget.listData.length < 1
            ? Center(
                child: Text("Take a shot at building this pattern!"),
              ).inGridArea('leaderboard')
            : Expanded(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: widget.listData.length,
                  itemBuilder: (context, index) {
                    return LeaderboardTile(
                        index: index + 1,
                        name: widget.listData[index]['name'],
                        numTiles: widget.listData[index]['numTiles']);
                    /*ListTile(
                title: Text(
                  '${index + 1}. ${widget.listData[index]['user']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${widget.listData[index]['tileSet']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ); */
                  },
                ),
              ).inGridArea('leaderboard'),
        //make a row with an elevated button that expands to its available space
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.009)),
                    child: Text(
                      "Add Entry",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.0065),
                    ),
                    onPressed: widget.onAddEntry)),
          ],
        )
      ],
    );
  }
}
