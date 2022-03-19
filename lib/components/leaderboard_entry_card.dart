import 'package:flutter/material.dart';

class LeaderboardEntryCard extends StatefulWidget {
  bool verification;
  Function(Map) addToLeaderboard;
  LeaderboardEntryCard(
      {Key? key, required this.verification, required this.addToLeaderboard})
      : super(key: key);

  @override
  State<LeaderboardEntryCard> createState() => _LeaderboardEntryCardState();
}

class _LeaderboardEntryCardState extends State<LeaderboardEntryCard> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.verification
          ? Color.fromARGB(137, 76, 175, 79)
          : Color.fromARGB(153, 255, 63, 63),
      child: Expanded(
          child: Column(children: [
        Expanded(
          child: Row(
            children: [
              widget.verification
                  ? Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: TextField(
                            autofocus: true,
                            decoration: const InputDecoration(
                              labelText: "Name",
                            ),
                            onSubmitted: (value) {
                              widget.addToLeaderboard({
                                'user': value,
                                'tileSet': {'L': 0, 'R': 0, 'U': 0, 'D': 0},
                              });
                              // Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  : Column(
                      children: [Text("Failed to verify :(")],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        )
      ])),
    );
  }
}
