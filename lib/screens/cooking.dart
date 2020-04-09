import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/Text/HeaderText/headerText.dart';
import '../components/Icon/CookingIcon/cookingIcon.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ffo/components/Text/HeaderText/styles.dart';
import 'package:ffo/components/Header/CancelHeader/cancelHeader.dart';

class Cooking extends StatefulWidget {

  @override
  _CookingState createState() => _CookingState();
}

class _CookingState extends State<Cooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget>[
                CancelHeader(),
                Expanded(
                  child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                Center(
                  child: Text("Cooking.",
  style: headerStyle
)),
                Center(child: CookingIcon()),
            ]))])
          ),)
    ;
  }
}
