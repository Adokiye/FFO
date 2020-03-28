import 'package:flutter/material.dart';
import 'styles.dart';

class FoodFoundText extends StatelessWidget {
  final String text;
  FoodFoundText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return new Text(text, style: foodFoundStyle);
  }
}
