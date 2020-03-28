import 'package:flutter/material.dart';
import 'styles.dart';

class RecipeText extends StatelessWidget {
  final String text;
  RecipeText({
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: MediaQuery.of(context).size.width * 0.85,
        margin: EdgeInsets.only(top: 21.0),
        child: Text(text, style: recipeStyle));
  }
}
