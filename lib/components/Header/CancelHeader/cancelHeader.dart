
import 'package:flutter/material.dart';

class CancelHeader extends StatelessWidget {
 // final String text;
  final GestureTapCallback onPressed;
  CancelHeader({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width*0.85,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
               RawMaterialButton(
      fillColor: Colors.white,
      child: Container(
        width: 40.0,
        height: 40.0,
        child: Center(
          child: Container(
          width: 17.0,
          height: 17.0,
          child: Image.asset('assets/images/blackCancel.png')),)
      ),
      onPressed: onPressed,
    ),
        ],
      )
    );
  }
}
