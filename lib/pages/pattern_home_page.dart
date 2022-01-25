import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:pats_project/components/pattern_item.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class PatternHomePage extends StatefulWidget {
  const PatternHomePage({Key? key}) : super(key: key);

  @override
  _PatternHomePageState createState() => _PatternHomePageState();
}

class _PatternHomePageState extends State<PatternHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pattern Home Page'),
      ),
      body: LayoutGrid(
        areas: '''
        . header  header  .       .      . 
        . content content content .      .
        . content content content .      .
        . content content content .      .
        . footer  footer  .       button .
        . .       .       .       .      .
        ''',
        columnSizes: [0.2.fr, 1.fr, 1.fr, 1.5.fr, 0.3.fr, 0.15.fr],
        rowSizes: [0.2.fr, 1.fr, 1.fr, 1.5.fr, 0.3.fr, 0.15.fr],
        children: [
          ElevatedButton(
            onPressed: () {
              context.go('/add_pattern');
            },
            child: Text(
              '+',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.05),
            ),
            style: ElevatedButton.styleFrom(shape: const CircleBorder()),
          ).inGridArea('button'),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('patterns_homepage')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //if snapshot has data, then return a gridview with the data
              if (snapshot.hasData) {
                print(snapshot.data.docs.length);
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7, childAspectRatio: 0.85),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(snapshot.data.docs[index].data()['image']);
                    return PatternItem(
                        projectKey: snapshot.data.docs[index].data()['name'],
                        projectTitle:
                            snapshot.data.docs[index].data()['project_name'],
                        imageUrl: snapshot.data.docs[index].data()['image']);
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ).inGridArea('content')
        ],
      ),
    );
  }
}
