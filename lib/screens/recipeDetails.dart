import 'package:flutter/material.dart';
import '../components/Text/HeaderText/headerText.dart';
import '../components/FoodBox/RecipeFoodBox/recipeFoodBox.dart';

class RecipeDetails extends StatefulWidget {
  RecipeDetails({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Expanded(child: Column(children: <Widget>[
        
      ],),),
    );
  }
}
