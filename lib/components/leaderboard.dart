import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:pats_project/components/leaderboard_tile.dart';
import 'package:pats_project/components/tile_container.dart';

class Leaderboard extends StatefulWidget {
  List<Map> listData;
  Function() onAddEntry;
  String projectId;
  Leaderboard(
      {Key? key,
      required this.listData,
      required this.projectId,
      required this.onAddEntry})
      : super(key: key);

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  void initState() {
    //implement initState
    super.initState();

    print("here is id: " + widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutGrid(
      areas: '''
      leaderboard
      .
      button
      ''',
      columnSizes: [1.fr],
      rowSizes: [1.8.fr, 0.1.fr, 0.2.fr],
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('patterns')
                .doc(widget.projectId)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print("here is data");
                print(snapshot.data!.data()['leaderboard']);
                //save data to list
                List<dynamic> leaderboard =
                    snapshot.data!.data()['leaderboard'];
                //sort leaderboard
                leaderboard
                    .sort((a, b) => (a['numTiles']).compareTo(b['numTiles']));
                print(leaderboard);
                return snapshot.data!.data()['leaderboard'].length < 1
                    ? Center(
                        child: Text("Take a shot at building this pattern!"),
                      )
                    : ListView.builder(
                        itemCount: leaderboard.length,
                        itemBuilder: (context, index) {
                          print("I am being repainted at " + index.toString());
                          return LeaderboardTile(
                            index: index + 1,
                            name: leaderboard[index]['name'],
                            numTiles: leaderboard[index]['numTiles'],
                          );
                        },
                      );
              }
              return Center(
                child: Text("Take a shot at building this pattern!"),
              );
            }).inGridArea('leaderboard'),
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
