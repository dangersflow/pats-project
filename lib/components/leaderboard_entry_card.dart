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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            style: BorderStyle.solid,
            width: 3,
            color: widget.verification
                ? Color.fromARGB(137, 76, 175, 79)
                : Color.fromARGB(153, 255, 63, 63),
          )),
      child: Expanded(
          child: Column(children: [
        Expanded(
          child: Row(
            children: [
              widget.verification
                  ? Column(
                      children: [
                        Text(
                          "Verification Successful!",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.008),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                0,
                                MediaQuery.of(context).size.height * 0.01,
                                0,
                                0)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
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
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                0,
                                MediaQuery.of(context).size.height * 0.02,
                                0,
                                0)),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(20)),
                                child: Text(
                                  "Try Again",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.008),
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.01,
                                    0,
                                    0,
                                    0)),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(20)),
                                child: Text(
                                  "Submit Submission",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.008),
                                ))
                          ],
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  : Column(
                      children: [
                        Text(
                          "Failed to verify :(",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.008),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                0,
                                MediaQuery.of(context).size.height * 0.02,
                                0,
                                0)),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(20)),
                                child: Text("Try Again",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.008))),
                          ],
                        )
                      ],
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
