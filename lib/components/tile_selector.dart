import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pats_project/components/tile.dart';

class TileSelector extends StatefulWidget {
  Function(Tile)? changeCurrentTile;
  TileSelector({Key? key, this.changeCurrentTile}) : super(key: key);

  @override
  _TileSelectorState createState() => _TileSelectorState();
}

class _TileSelectorState extends State<TileSelector> {
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
    Tile tile = Tile(color: pickerColor);
    widget.changeCurrentTile!(tile);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Card(
          child: Column(
            children: [
              Row(
                children: [
                  Tile(color: pickerColor, x: 250, y: 250),
                  SizedBox(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      child: ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: changeColor,
                        hexInputBar: true,
                        portraitOnly: true,
                      ),
                    ),
                    height: 500,
                    width: 500,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
        ),
      ),
    );
  }
}
