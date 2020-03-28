import 'package:flutter/material.dart';
import 'styles.dart';

class HeaderText extends StatelessWidget {
  final String text;
  HeaderText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: MediaQuery.of(context).size.width * 0.85,
        child: new Text(text, style: lightStyle));
  }
}
