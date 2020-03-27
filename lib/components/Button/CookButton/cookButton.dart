import 'package:flutter/material.dart';
import 'styles.dart';

class CookButton extends StatelessWidget {
 // final String text;
  final GestureTapCallback onPressed;
  CookButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: const Color(0xffEF383F),
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(4.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 47.0,
        child: Center(child: Text('COOK', style: cookTextStyle,),),
      ),
      onPressed: onPressed,
    );
  }
}
