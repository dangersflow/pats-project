import 'package:flutter/material.dart';
import 'package:pats_project/components/tile.dart';

class PatternSelector extends StatefulWidget {
  Tile currentlySelectedTile;
  List<Tile> grid;
  Function(int, int) createGrid;
  Function(int, int) changeGridSize;
  TextEditingController xController;
  TextEditingController yController;
  PatternSelector(
      {Key? key,
      required this.currentlySelectedTile,
      required this.grid,
      required this.createGrid,
      required this.changeGridSize,
      required this.xController,
      required this.yController})
      : super(key: key);

  @override
  _PatternSelectorState createState() => _PatternSelectorState();
}

class _PatternSelectorState extends State<PatternSelector> {
  //TextEditingController xController = TextEditingController();
  //TextEditingController yController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //set the controllers to a default value
    setState(() {
      widget.xController.text = '5';
      widget.yController.text = '5';
    });

    //create a grid of grey tiles into the grid list
    widget.createGrid(
        int.parse(widget.xController.text), int.parse(widget.yController.text));
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
                  controller: widget.xController,
                  decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      label: Text("X Value"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                      )),
                  onSubmitted: (value) {
                    setState(() {
                      widget.xController.text = value;
                      widget.yController.text = value;
                    });
                    widget.changeGridSize(int.parse(widget.xController.text),
                        int.parse(widget.yController.text));
                  },
                ),
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              SizedBox(
                child: TextField(
                  controller: widget.yController,
                  decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      label: Text("Y Value"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                      )),
                  onSubmitted: (value) {
                    setState(() {
                      widget.xController.text = value;
                      widget.yController.text = value;
                    });
                    widget.changeGridSize(int.parse(widget.xController.text),
                        int.parse(widget.yController.text));
                  },
                ),
                width: MediaQuery.of(context).size.width * 0.1,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          //add a gridview builder using the controllers
          Expanded(
            child: GestureDetector(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: int.parse(widget.xController.text),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                reverse: true,
                itemCount: int.parse(widget.yController.text) *
                    int.parse(widget.xController.text),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: widget.grid[index],
                    onTap: () {
                      setState(() {
                        widget.grid[index] = widget.currentlySelectedTile;
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
