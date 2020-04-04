import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/Text/HeaderText/headerText.dart';
import '../components/Text/LightText/lightText.dart';
import '../components/Header/CancelHeader/cancelHeader.dart';

class NotFound extends StatefulWidget {
  final String header;
  final String subText;
  NotFound({@required this.header, 
  @required this.subText});

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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      HeaderText(text: widget.header,),
                      LightText(text: widget.subText)
                    ],
                  )
                )
            ])
          ),),
    );
  }
}
