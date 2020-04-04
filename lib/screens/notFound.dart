import 'package:flutter/material.dart';
import '../components/Text/HeaderText/headerText.dart';
import '../components/Text/LightText/lightText.dart';
import '../components/Header/CancelHeader/cancelHeader.dart';

class NotFound extends StatefulWidget {
  NotFound({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NotFoundState createState() => _NotFoundState();
}

class _NotFoundState extends State<NotFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
                CancelHeader(onPressed: null,),
                
            ])
          ),),
    );
  }
}
