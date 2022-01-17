import 'package:flutter/material.dart';
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

    print(widget.listData[0]['tileSet']);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: widget.listData.length,
            itemBuilder: (context, index) {
              return LeaderboardTile(
                  index: index + 1,
                  name: widget.listData[index]['user'],
                  tiles: widget.listData[index]['tileSet']);
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
        ),
        Row(
          children: [
            InkWell(
              child: Container(
                child: const Text("Add Entry"),
                padding: const EdgeInsets.all(10),
              ),
              onTap: widget.onAddEntry,
              borderRadius: BorderRadius.circular(10),
            )
          ],
        )
      ],
    );
  }
}
