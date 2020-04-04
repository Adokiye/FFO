import 'package:flutter/material.dart';
import 'styles.dart';

class AddFoodBox extends StatelessWidget {
  final String text;
  AddFoodBox({@required this.text});

  @override
  Widget build(BuildContext context) {
    return new Container(
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
                    )));
  }
}
