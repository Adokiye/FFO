import 'package:flutter/material.dart';
import 'package:ffo/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FFO',
      theme: ThemeData(
        primaryColor: const Color(0xffEF383F),
      ),
      home: MyHomePage(title: 'FFO'),
    );
  }
}


