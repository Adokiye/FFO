import 'package:flutter/material.dart';
import 'styles.dart';

class YellowButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;
  YellowButton({@required this.onPressed, @required this.text});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: const Color(0xffFBAE17),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(4.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 47.0,
        child: Center(child: Text(text, style: cookTextStyle,),),
      ),
      onPressed: onPressed,
    );
  }
}
