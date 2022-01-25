import 'package:flutter/material.dart';

class PatternSelector extends StatefulWidget {
  const PatternSelector({Key? key}) : super(key: key);

  @override
  _PatternSelectorState createState() => _PatternSelectorState();
}

class _PatternSelectorState extends State<PatternSelector> {
  TextEditingController xController = TextEditingController();
  TextEditingController yController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //set the controllers to a default value
    xController.text = '5';
    yController.text = '5';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              child: TextField(
                controller: xController,
                decoration: InputDecoration(
                    alignLabelWithHint: true, label: Text("X Value")),
                onSubmitted: (value) => {
                  setState(() {
                    xController.text = value;
                    yController.text = value;
                  })
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
                onSubmitted: (value) => {
                  setState(() {
                    xController.text = value;
                    yController.text = value;
                  })
                },
              ),
              width: MediaQuery.of(context).size.width * 0.1,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
        //add a gridview builder using the controllers
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: int.parse(xController.text),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount:
                int.parse(yController.text) * int.parse(xController.text),
            itemBuilder: (context, index) {
              return Container(
                color: Colors.grey,
                child: Center(
                  child: Text(
                    '$index',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
