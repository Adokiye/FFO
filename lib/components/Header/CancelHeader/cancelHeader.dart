
import 'package:flutter/material.dart';

class CancelHeader extends StatelessWidget {
 // final String text;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width*0.85,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
               RawMaterialButton(
    //  fillColor: Colors.white,
      child: Container(
        width: 40.0,
        height: 40.0,
        child: Center(
          child: Container(
          width: 17.0,
          height: 17.0,
          child: Image.asset('assets/images/blackCancel.png')),)
      ),
      onPressed: (){Navigator.pop(context);},
    ),
        ],
      )
    );
  }
}
