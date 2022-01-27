import 'package:flutter/material.dart';
import 'package:pats_project/components/tile.dart';

class PatternSelector extends StatefulWidget {
  Tile currentlySelectedTile;
  PatternSelector({Key? key, required this.currentlySelectedTile})
      : super(key: key);

  @override
  _PatternSelectorState createState() => _PatternSelectorState();
}

class _PatternSelectorState extends State<PatternSelector> {
  TextEditingController xController = TextEditingController();
  TextEditingController yController = TextEditingController();
  List<Tile> grid = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //set the controllers to a default value
    xController.text = '5';
    yController.text = '5';

    //create a grid of grey tiles into the grid list
    for (int i = 0;
        i < int.parse(xController.text) * int.parse(yController.text);
        i++) {
      grid.add(Tile(
        color: Colors.grey,
        id: i + 1,
        showGlues: true,
      ));
    }
  }

  void changeGridSize() {
    setState(() {
      grid = [];
      for (int i = 0;
          i < int.parse(xController.text) * int.parse(yController.text);
          i++) {
        grid.add(Tile(
          color: Colors.grey,
          id: i + 1,
          showGlues: true,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                child: TextField(
                  controller: xController,
                  decoration: InputDecoration(
                      alignLabelWithHint: true, label: Text("X Value")),
                  onSubmitted: (value) {
                    setState(() {
                      xController.text = value;
                      yController.text = value;
                    });
                    changeGridSize();
                  },
                ),
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              SizedBox(
                child: TextField(
                  controller: yController,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    label: Text("Y Value"),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      xController.text = value;
                      yController.text = value;
                    });
                    changeGridSize();
                  },
                ),
                width: MediaQuery.of(context).size.width * 0.1,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
          //add a gridview builder using the controllers
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: int.parse(xController.text),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              reverse: true,
              itemCount:
                  int.parse(yController.text) * int.parse(xController.text),
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: grid[index],
                  onTap: () {
                    setState(() {
                      grid[index] = widget.currentlySelectedTile;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 0, 0, MediaQuery.of(context).size.width * 0.03)),
        ],
      ),
    );
  }
}
