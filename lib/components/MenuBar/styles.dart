import 'dart:ui';

import 'package:flutter/material.dart';

TextStyle unpressedTextStyle =
    TextStyle(fontFamily: 'Poppins',color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600);

TextStyle pressedTextStyle =
    TextStyle(fontFamily: 'Poppins',color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w600);

BoxDecoration parentDecorationStyle = BoxDecoration(
    border: Border.all(
      color: const Color(0xffdce0e7),
    ),
    color: const Color(0xfffafafb));

BoxDecoration unpressedDecorationStyle = BoxDecoration(
 // color: const Color(0xfffafafb),
);

BoxDecoration pressedDecorationStyle = BoxDecoration(
  //  color: const Color(0xffE64C3C),
   // borderRadius: BorderRadius.circular(5.0),
    boxShadow: [
      BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.15),
          blurRadius: 13.0,
          offset: Offset(0.0, 4.0))
    ]);
