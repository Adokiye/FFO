import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  // final String text;
  final GestureTapCallback onPressed;
  SendButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
      onTap: onPressed,
      child: Container(
        width: 70.0,
        height: 70.0,
        child: Image.asset(
          'assets/images/send.png',
          fit: BoxFit.contain,
        ),
      ),
    ));
  }
}
