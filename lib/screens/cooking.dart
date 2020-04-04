import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/Text/HeaderText/headerText.dart';
import '../components/Icon/CookingIcon/cookingIcon.dart';

class Cooking extends StatefulWidget {
  final String header;
  final String subText;
  Cooking({@required this.header, 
  @required this.subText});

  @override
  _CookingState createState() => _CookingState();
}

class _CookingState extends State<Cooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                HeaderText(text: 'Cooking.',),
                CookingIcon(),
            ])
          ),),
    );
  }
}
