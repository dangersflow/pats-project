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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // exampleData
  //     .sort((a, b) => (a['tileSet'].length).compareTo(b['tileSet'].length));

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
          return ViewPatternPage(projectKey: pattern);
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
