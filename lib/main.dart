import 'package:flutter/material.dart';
import 'package:pats_project/components/leaderboard.dart';
import 'package:pats_project/components/pattern_display.dart';
import 'package:pats_project/components/tile_set_entry.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:go_router/go_router.dart';
import 'package:pats_project/pages/add_pattern_page.dart';
import 'package:pats_project/pages/pattern_home_page.dart';
import 'package:pats_project/pages/view_pattern_page.dart';
import 'pages/log_in_page.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // exampleData
  //     .sort((a, b) => (a['tileSet'].length).compareTo(b['tileSet'].length));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? currentUser = null;
  bool loggedIn = false;
  bool darkMode = false;
  GoRouter? _router;

  void changeTheme(bool value) {
    setState(() {
      darkMode = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _router = GoRouter(
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LogInPage(),
        ),
        GoRoute(
            path: '/',
            builder: (context, state) => PatternHomePage(
                  darkMode: darkMode,
                  changeTheme: changeTheme,
                )),
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

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        setState(() {
          currentUser = user;
          loggedIn = true;
        });
      }
    });

    return MaterialApp.router(
      routeInformationParser: _router!.routeInformationParser,
      routerDelegate: _router!.routerDelegate,
      title: 'PATS Project',
      theme: darkMode ? ThemeData.dark() : ThemeData.light(),
    );
  }
}
