import 'package:flutter/material.dart';

class ExpandableCard extends StatefulWidget {
  Widget child;
  Duration duration;
  Curve curve;
  ExpandableCard(
      {Key? key,
      required this.child,
      required this.duration,
      required this.curve})
      : super(key: key);

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: AnimatedContainer(
        duration: widget.duration,
        curve: widget.curve,
        height: expanded ? MediaQuery.of(context).size.height * 0.45 : 0.1,
        child: expanded ? widget.child : Text("I am not expanded"),
      ),
    );
  }
}
