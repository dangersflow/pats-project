import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pats_project/components/tile.dart';
import 'package:screenshot/screenshot.dart';

class PatternSelector extends StatefulWidget {
  Tile currentlySelectedTile;
  bool hasATileSelected;
  List<Tile> grid;
  Function(int, int) createGrid;
  Function(int, int) changeGridSize;
  TextEditingController xController;
  TextEditingController yController;
  ScreenshotController screenshotController;
  PatternSelector(
      {Key? key,
      required this.currentlySelectedTile,
      required this.grid,
      required this.createGrid,
      required this.changeGridSize,
      required this.xController,
      required this.yController,
      required this.screenshotController,
      required this.hasATileSelected})
      : super(key: key);

  @override
  _PatternSelectorState createState() => _PatternSelectorState();
}

class _PatternSelectorState extends State<PatternSelector> {
  //TextEditingController xController = TextEditingController();
  //TextEditingController yController = TextEditingController();
  int maxSize = 500;

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
    return LayoutGrid(areas: '''
    fields
    grid
''', columnSizes: [
      1.fr
    ], rowSizes: [
      0.1.fr,
      1.fr,
    ], children: [
      Center(
        child: Row(
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
      ).inGridArea('fields'),
      //add a gridview builder using the controllers
      Screenshot(
        controller: widget.screenshotController,
        child: GestureDetector(
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: int.parse(widget.xController.text),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 1,
            ),
            reverse: true,
            itemCount: int.parse(widget.yController.text) *
                int.parse(widget.xController.text),
            itemBuilder: (context, index) {
              return GestureDetector(
                child: widget.grid[index],
                onTap: () {
                  setState(() {
                    if (widget.hasATileSelected) {
                      widget.grid[index] = widget.currentlySelectedTile;
                    } else {
                      MotionToast.error(
                        description: Text("Please select a tile!"),
                        animationDuration: Duration(milliseconds: 100),
                        animationCurve: Curves.easeInOutCubic,
                        toastDuration: Duration(milliseconds: 1000),
                      ).show(context);
                    }
                  });
                },
              );
            },
          ),
        ),
      ).inGridArea('grid'),
    ]);
  }
}
