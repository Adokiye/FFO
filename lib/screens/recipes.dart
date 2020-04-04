import 'package:flutter/material.dart';
import '../components/Text/HeaderText/headerText.dart';
import '../components/FoodBox/RecipeFoodBox/recipeFoodBox.dart';

class Recipes extends StatefulWidget {
  final List<String> ing;
    Recipes({Key key, this.title, @required this.ing}) : super(key: key);
  final String title;

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[
                Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075),
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                    child: InkWell(
                        onTap: null,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: const Color(0xffEF383F),
                          size: 24.0,
                        ))),
            ),
            Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075),
            child: HeaderText(text: 'Recipes Found',)),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  RecipeFoodBox(text: 'Jollof Rice', onPressed: null, time: '20mins',),
                  RecipeFoodBox(text: 'Fried Rice', onPressed: null, time: '20mins',)
                ],),
            )
            ]
          ),),
    );
  }
}
