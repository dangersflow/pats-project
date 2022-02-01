import 'package:flutter/material.dart';

class TilePool extends StatefulWidget {
  const TilePool({Key? key}) : super(key: key);

  @override
  _TilePoolState createState() => _TilePoolState();
}

class _TilePoolState extends State<TilePool> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Card(
            child: Text("I am a tile pool"),
          ),
        )
      ],
    );
  }
}
