import 'package:flutter/material.dart';
import 'styles.dart';

class CookingIcon extends StatefulWidget {
  @override
  _CookingIconState createState() {
    return _CookingIconState();
  }
}

class _CookingIconState extends State<CookingIcon> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          _alignment = Alignment.bottomLeft;
        }));
  }

  AlignmentGeometry _alignment = Alignment.center;
  _changeAlignment() {
    setState(() {
      _alignment = _alignment == Alignment.topRight
          ? Alignment.bottomLeft
          : Alignment.topRight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 66.0,
      height: 66.0,
      decoration: potDecorationStyle,
      child: AnimatedAlign(
          alignment: _alignment,
          curve: Curves.linear,
          duration: Duration(seconds: 1),
          onEnd: _changeAlignment,
          child: Container(
            width: 45.0,
            height: 45.0,
            decoration: foodDecorationStyle,
          )),
    );
  }
}
