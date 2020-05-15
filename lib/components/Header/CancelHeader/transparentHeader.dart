import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ffo/screens/home.dart';

class TransparentHeader extends StatefulWidget {
  final bool isRecognized;
  TransparentHeader({
    @required this.isRecognized,
  });

  @override
  _TransparentHeaderState createState() => _TransparentHeaderState();
}

class _TransparentHeaderState extends State<TransparentHeader> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RawMaterialButton(
              //  fillColor: Colors.white,
              child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                        width: 17.0,
                        height: 17.0,
                        child: Image.asset('assets/images/whiteCancel.png')),
                  )),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: MyHomePage()),
                    (Route<dynamic> route) => false);
              },
            ),
            AnimatedOpacity(
                // If the widget is visible, animate to 0.0 (invisible).
                // If the widget is hidden, animate to 1.0 (fully visible).
                opacity: widget.isRecognized ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                // The green box must be a child of the AnimatedOpacity widget.
                child: Container(
                  width: 160.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                  child: Center(
                      child: Text(
                    'ingredient recognized',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  )),
                ))
          ],
        ));
  }
}
