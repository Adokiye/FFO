import 'dart:ui';

import 'package:flutter/material.dart';


TextStyle plusStyle = TextStyle(fontFamily: 'Poppins',
                              color: const Color(0xffFBAE17),
                              fontSize: 23.0,
                              fontWeight: FontWeight.w500);

BoxDecoration boxDecorationStyle = BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          blurRadius: 13.0,
                          offset: Offset(0.0, 4.0)),
                          
                    ],color: Colors.white,
                        border: Border(
      bottom: BorderSide( //                   <--- left side
        color: const Color(0xffe5e5e5),
        width: 1.0,
      ),
    ));

TextStyle foodNameStyle = TextStyle(fontFamily: 'Poppins',color: Colors.black, fontSize: 17.0);