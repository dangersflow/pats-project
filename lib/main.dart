import 'package:flutter/material.dart';
import 'package:pats_project/components/leaderboard.dart';
import 'package:pats_project/components/pattern_display.dart';
import 'package:pats_project/components/tile_set_entry.dart';

List<Map> exampleData = [
  {
    'user': 'Tim',
    'image': 'https://randomuser.me/api/portraits/',
    'tileSet': {
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 1
      },
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 2
      },
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 3
      },
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 4
      },
    },
  },
  {
    'user': 'Frank',
    'image': 'https://randomuser.me/api/portraits/',
    'tileSet': {
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 1
      },
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 2
      },
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 3
      },
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 4
      },
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 5
      },
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 6
      },
    },
  },
  {
    'user': 'Wylie',
    'image': 'https://randomuser.me/api/portraits/',
    'tileSet': {
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 1
      },
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 2
      },
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 3
      },
    },
  },
  {
    'user': 'Schweller',
    'image': 'https://randomuser.me/api/portraits/',
    'tileSet': {
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 1
      },
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 2
      },
    },
  },
  {
    'user': 'Sonya',
    'image': 'https://randomuser.me/api/portraits/',
    'tileSet': {
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 1
      },
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 2
      },
    },
  },
  {
    'user': 'David',
    'image': 'https://randomuser.me/api/portraits/',
    'tileSet': {
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 1
      },
      {
        'glues': {'L': 'X', 'R': 'X', 'T': 'X', 'B': 'X'},
        'color': '0xFF9A031E',
        'id': 2
      },
    },
  }
];

void main() {
  exampleData
      .sort((a, b) => (a['tileSet'].length).compareTo(b['tileSet'].length));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: DemoScreen());
  }
}

class DemoScreen extends StatefulWidget {
  bool isTileEntryVisible;
  DemoScreen({Key? key, this.isTileEntryVisible = false}) : super(key: key);

  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
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
        title: const Text('Demo Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(children: [
              const Padding(padding: EdgeInsets.fromLTRB(100, 150, 0, 0)),
              Text(
                'Demo Pattern',
                style:
                    TextStyle(fontSize: MediaQuery.of(context).size.width / 50),
              ),
            ]),
            Row(
              children: [
                SizedBox(
                    child: PatternDisplay(x: 5, y: 5),
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3),
                const Padding(padding: EdgeInsets.fromLTRB(150, 0, 0, 0)),
                widget.isTileEntryVisible
                    ? SizedBox(
                        child: TileSetEntry(
                          hideTileSetEntry: hideTileSetEntry,
                          exampleData: exampleData,
                          updateData: updateData,
                        ),
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3)
                    : SizedBox(
                        child: Leaderboard(
                          listData: exampleData,
                          onAddEntry: showTileSetEntry,
                        ),
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                      ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
