import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PatternItem extends StatefulWidget {
  final String imageUrl;
  final String projectTitle;
  final String projectKey;
  const PatternItem(
      {Key? key,
      required this.imageUrl,
      required this.projectTitle,
      required this.projectKey})
      : super(key: key);

  @override
  _PatternItemState createState() => _PatternItemState();
}

class _PatternItemState extends State<PatternItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/patterns/${widget.projectKey}');
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: LayoutGrid(
          areas: '''
          .
          pattern
          divider
          name
          .
          ''',
          columnSizes: [1.fr],
          rowSizes: [0.05.fr, 0.8.fr, 0.1.fr, 0.1.fr, 0.05.fr],
          children: [
            Center(
              // child: Image.network(
              //   widget.imageUrl,
              //   fit: BoxFit.fitWidth,
              // ),
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ).inGridArea('pattern'),
            const Center(
              child: Divider(
                thickness: 1,
                color: Colors.black,
              ),
            ).inGridArea('divider'),
            Center(
              child: Text(
                widget.projectTitle,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.010),
              ),
            ).inGridArea('name')
          ],
        ),
      ),
    );
  }
}
