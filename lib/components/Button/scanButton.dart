import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
 // final String text;
  final GestureTapCallback onPressed;
  ScanButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: const Color(0xffEF383F),
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(13.0),
      ),
      child: Container(
        width: 121.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/fingerprint.png',
              height: 20,
              width: 20,
              fit: BoxFit.contain,
            ),
            Text(
              'Scan to add',
              //        textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 13.0),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
