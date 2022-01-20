import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PatternHomePage extends StatefulWidget {
  const PatternHomePage({Key? key}) : super(key: key);

  @override
  _PatternHomePageState createState() => _PatternHomePageState();
}

class _PatternHomePageState extends State<PatternHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PATS PROJECT"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Press me :)"),
          onPressed: () => context.go('/pattern'),
        ),
      ),
    );
  }
}
