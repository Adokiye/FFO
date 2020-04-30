import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/Text/HeaderText/headerText.dart';
import '../components/Text/LightText/lightText.dart';
import 'package:ffo/screens/home.dart';
import 'package:ffo/screens/camera.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ffo/components/Button/YellowButton/yellowButton.dart';

class Retry extends StatefulWidget {
  final String header;
  final String subText;
  Retry({this.header, this.subText});

  @override
  _RetryState createState() => _RetryState();
}

class _RetryState extends State<Retry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.04),
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
                                child: Image.asset(
                                    'assets/images/blackCancel.png')),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: MyHomePage()));
                      },
                    ),
                  ],
                )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: HeaderText(
                  text: 'Ingredient not recognized',
                )),
                Center(child: LightText(text: 'Try taking a clearer picture')),
                Center(child: HeaderText(text: '☹️')),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.20),
                    child: YellowButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.leftToRightWithFade,
                                  child: Camera()));
                        },
                        text: 'RETRY')),
              ],
            ))
          ])),
    );
  }
}
