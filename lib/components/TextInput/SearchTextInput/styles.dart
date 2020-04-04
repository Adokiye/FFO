import 'dart:ui';

import 'package:flutter/material.dart';

InputDecoration inputDecoration1 = InputDecoration(
  hintText: 'Search for Ingredients',
  hintStyle: hintStyle1,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: const Color(0xffDCE0E7), width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: const Color(0xffEF383F), width: 1.0),
  ),
  fillColor: const Color(0xfffafafb),
  filled: true,
  prefixIcon: Icon(
    Icons.search,
    color: const Color(0xffEF383F),
    size: 25.0,
  ),
);

TextStyle hintStyle1 = TextStyle(fontFamily: 'Poppins',
  fontSize: 13.0,
  color: const Color(0xff979797),
);

TextStyle enteredTextStyle1 = TextStyle(fontFamily: 'Poppins',
  fontSize: 13.0,
  color: Colors.black,
);
