import 'styles.dart';
import 'package:flutter/material.dart';

class ImageFoundHeader extends StatelessWidget {
 // final String text;
  final GestureTapCallback onPressed;
  ImageFoundHeader({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width*0.85,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
               RawMaterialButton(
      fillColor: Color.fromRGBO(0, 0, 0, 0.5),
      shape: circleShape,
      child: Container(
        width: 40.0,
        height: 40.0,
        child: Center(
          child: Container(
          width: 17.0,
          height: 17.0,
          child: Image.asset('assets/images/whiteCancel.png')),)
      ),
      onPressed: onPressed,
    ),
    AnimatedOpacity(
  // If the widget is visible, animate to 0.0 (invisible).
  // If the widget is hidden, animate to 1.0 (fully visible).
  opacity: 1.0,
  duration: Duration(milliseconds: 1000),
  // The green box must be a child of the AnimatedOpacity widget.
  child: Container(
    padding: EdgeInsets.all(10.0),
    color: Color.fromRGBO(0, 0, 0, 0.5),
    decoration: secondBoxDecorationStyle,
    child: Center(child: Text('Ingredient recognized', style: secondTextStyle),),
  ),
)
        ],
      )
    );
  }
}
