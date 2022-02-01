import 'package:flutter/material.dart';
import 'package:pats_project/components/leaderboard.dart';
import 'package:pats_project/components/pattern_display.dart';
import 'package:pats_project/components/tile_set_entry.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:go_router/go_router.dart';
import 'package:pats_project/pages/add_pattern_page.dart';
import 'package:pats_project/pages/pattern_home_page.dart';
import 'package:pats_project/pages/view_pattern_page.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  exampleData
      .sort((a, b) => (a['tileSet'].length).compareTo(b['tileSet'].length));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'GoRouter Example',
      );

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const PatternHomePage(),
      ),
      GoRoute(
        path: '/patterns/:pattern',
        builder: (context, state) {
          final pattern = state.params['pattern'];
          return DemoScreen(
            pattern: pattern,
          );
        },
      ),
      GoRoute(
        path: '/add_pattern',
        builder: (context, state) {
          final pattern = state.params['pattern'];
          return AddPatternPage();
        },
      )
    ],
  );
}

class DemoScreen extends StatefulWidget {
  bool isTileEntryVisible;
  String? pattern;
  DemoScreen({Key? key, this.isTileEntryVisible = false, required this.pattern})
      : super(key: key);

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
          title: InkWell(
            child: Text("PATS PROJECT"),
            onTap: () {
              context.go('/');
            },
            splashColor: Colors.transparent,
            enableFeedback: false,
            splashFactory: NoSplash.splashFactory,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ),
        body: LayoutGrid(
          areas: '''
         . .             .             . .            .
         . patternHeader patternHeader . .            .
         . pattern       pattern       . leaderboard  .
         . pattern       pattern       . leaderboard  .
         . footer        footer        . .            .
        ''',
          columnSizes: [0.2.fr, 1.fr, auto, auto, 1.fr, 0.2.fr],
          rowSizes: [
            0.1.fr,
            0.2.fr,
            1.fr,
            1.fr,
            0.1.fr,
          ],
          // Column and row gaps! 🔥
          columnGap: 12,
          rowGap: 12,
          children: [
            Text(
              'Square',
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width / 50),
            ).inGridArea('patternHeader'),
            SizedBox(
              child: PatternDisplay(
                x: 5,
                y: 5,
              ),
              width: MediaQuery.of(context).size.width / 3,
            ).inGridArea('pattern'),
            widget.isTileEntryVisible
                ? TileSetEntry(
                    hideTileSetEntry: hideTileSetEntry,
                    exampleData: exampleData,
                    updateData: updateData,
                  ).inGridArea('leaderboard')
                : Leaderboard(
                    listData: exampleData,
                    onAddEntry: showTileSetEntry,
                  ).inGridArea('leaderboard'),
          ],
        )
        // Center(
        //   child: Column(
        //     children: [
        //       Row(children: [
        //         const Padding(padding: EdgeInsets.fromLTRB(100, 150, 0, 0)),
        //         Text(
        //           'Demo Pattern',
        //           style:
        //               TextStyle(fontSize: MediaQuery.of(context).size.width / 50),
        //         ),
        //       ]),
        //       Row(
        //         children: [
        //           SizedBox(
        //               child: PatternDisplay(x: 5, y: 5),
        //               width: MediaQuery.of(context).size.width / 3,
        //               height: MediaQuery.of(context).size.width / 3),
        //           const Padding(padding: EdgeInsets.fromLTRB(150, 0, 0, 0)),
        //           widget.isTileEntryVisible
        //               ? SizedBox(
        //                   child: TileSetEntry(
        //                     hideTileSetEntry: hideTileSetEntry,
        //                     exampleData: exampleData,
        //                     updateData: updateData,
        //                   ),
        //                   width: MediaQuery.of(context).size.width / 3,
        //                   height: MediaQuery.of(context).size.width / 3)
        //               : SizedBox(
        //                   child: Leaderboard(
        //                     listData: exampleData,
        //                     onAddEntry: showTileSetEntry,
        //                   ),
        //                   width: MediaQuery.of(context).size.width / 3,
        //                   height: MediaQuery.of(context).size.width / 3,
        //                 ),
        //         ],
        //         mainAxisAlignment: MainAxisAlignment.center,
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
