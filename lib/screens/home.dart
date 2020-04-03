import 'package:flutter/material.dart';
import '../components/Text/HeaderText/headerText.dart'

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SafeArea(
              child: SingleChildScrollView(
            child: Expanded(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    HeaderText('Add your ingredients')
                          ])
           ) )),
        );
  }
}
