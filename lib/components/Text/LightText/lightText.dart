import 'package:flutter/material.dart';
import 'styles.dart';

class LightText extends StatelessWidget {
  final String text;
  LightText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return new Text(text, style: lightStyle);
  }
}
