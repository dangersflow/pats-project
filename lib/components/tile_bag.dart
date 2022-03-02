import 'package:flutter/material.dart';
import 'package:pats_project/components/tile.dart';

class TileBag extends StatefulWidget {
  List<Tile> tileBag;
  TileBag({Key? key, required this.tileBag}) : super(key: key);

  @override
  State<TileBag> createState() => _TileBagState();
}

class _TileBagState extends State<TileBag> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
