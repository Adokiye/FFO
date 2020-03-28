import 'package:flutter/material.dart';
import 'styles.dart';

class HeaderText extends StatelessWidget {
  final String text;
  HeaderText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return new Text(text, style: headerStyle);
  }
}
