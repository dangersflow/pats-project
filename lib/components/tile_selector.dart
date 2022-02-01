import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pats_project/components/tile.dart';
import 'package:pats_project/components/tile_pool.dart';

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
      child: Row(
        children: [
          Column(
            children: [
              //Tile(color: pickerColor, x: 250, y: 250),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  child: Column(
                    children: [
                      ColorPicker(
                        colorPickerWidth: 200,
                        pickerColor: pickerColor,
                        onColorChanged: changeColor,
                        hexInputBar: true,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: BeveledRectangleBorder()),
                                child: Text("Add"),
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
              ),
              TilePool()
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
