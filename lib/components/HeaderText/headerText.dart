import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String text;
  HeaderText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return new Text(text, style: TextStyle(fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.w600),);
  }
}
