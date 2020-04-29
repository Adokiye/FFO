import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/Text/HeaderText/headerText.dart';
import '../components/Text/LightText/lightText.dart';
import '../components/Header/CancelHeader/cancelHeader.dart';
import 'dart:io';

class AddNewIngredient extends StatefulWidget {
  final String path;
  AddNewIngredient({@required this.path, });

  @override
  _AddNewIngredientState createState() => _AddNewIngredientState();
}

class _AddNewIngredientState extends State<AddNewIngredient> {
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
                Center(
                  child: Container(
      width: MediaQuery.of(context).size.width*0.85,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04, bottom: 12.0),
      child: HeaderText(text: 'Add Ingredient',)
    )),
    Center(
      child: Image.file(
              File(widget.path),
              fit: BoxFit.cover,
              height: 140,
              width: MediaQuery.of(context).size.width*0.85,
              alignment: Alignment.center,
            )
    ),
             Center(
                  child: Container(
      width: MediaQuery.of(context).size.width*0.85,
      padding: EdgeInsets.only(top: 12.0),
      child: LightText(text: 'Add this ingredient to our database for better identification later on. For Food Only\'s Nigerian ingredients model still has a lot to learn and with your help it can get smarter 😉.',)
    )),
            ])
          ),
    );
  }
}
