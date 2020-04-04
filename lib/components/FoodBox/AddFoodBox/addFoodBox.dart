import 'package:flutter/material.dart';
import 'styles.dart';

class AddFoodBox extends StatelessWidget {
  final String text;
  final Function() onPressed;
  AddFoodBox({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
                height: 51.0,
      child: Material(
        color: Colors.white,
        child: InkWell(
            onTap:() => onPressed,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 51.0,
                decoration: boxDecorationStyle,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          text,
                          style: foodNameStyle,
                        ),
                        Text(
                          '+',
                          style: plusStyle),
                      ],
                    ))))));
  }
}
