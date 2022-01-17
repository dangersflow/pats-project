import 'package:flutter/material.dart';

class TileContainer extends StatefulWidget {
  const TileContainer({Key? key}) : super(key: key);

  @override
  _TileContainerState createState() => _TileContainerState();
}

class _TileContainerState extends State<TileContainer> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        borderOnForeground: true,
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                ),
                itemCount: count,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.height * 0.05,
                    height: MediaQuery.of(context).size.height * 0.05,
                    margin: EdgeInsets.all(5),
                    color: Colors.red,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        count++;
                      });
                    },
                    child: Text('+', style: TextStyle(fontSize: 32)),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        elevation: 5,
                        padding: EdgeInsets.all(15))),
              ],
            )
          ],
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.3,
    );
  }
}
