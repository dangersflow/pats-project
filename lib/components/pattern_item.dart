import 'package:flutter/material.dart';
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
        child: Wrap(
          children: [
            Column(
              children: [
                Container(
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
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Text(
                      widget.projectTitle,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.010),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
            )
          ],
        ),
      ),
    );
  }
}
