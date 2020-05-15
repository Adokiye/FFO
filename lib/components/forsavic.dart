// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double width = 100.0;
  List<Widget> containers = [Container(
  width: 300,
    height: 60,
    margin: EdgeInsets.only(bottom: 10.0),
    decoration: BoxDecoration(
    color: Color(0xffFF008C),
     borderRadius: new BorderRadius.circular(10.0),
     
    )
  ),
      Container(
  width: 300,
    height: 80,
    margin: EdgeInsets.only(bottom: 10.0),
    decoration: BoxDecoration(
    color: Color(0xffD309E1),
     borderRadius: new BorderRadius.circular(10.0),
     
    )
  ),  
                                   Container(
  width: 300,
    height: 40,
    margin: EdgeInsets.only(bottom: 10.0),
    decoration: BoxDecoration(
    color: Color(0xff9C1AFF),
     borderRadius: new BorderRadius.circular(10.0),
     
    )
  ), 
                                   Container(
  width: 300,
    height: 100,
    margin: EdgeInsets.only(bottom: 10.0),
    decoration: BoxDecoration(
    color: Color(0xff7700FF),
     borderRadius: new BorderRadius.circular(10.0),
     
    )
  ), 
                            ];
void _onReorder(int oldIndex, int newIndex) {
  setState(
    () {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Widget item = containers.removeAt(oldIndex);
      containers.insert(newIndex, item);
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ReorderableListView(
  onReorder: _onReorder,
  scrollDirection: Axis.vertical,
  children: containers,
),
      ),
    );
  }
}


