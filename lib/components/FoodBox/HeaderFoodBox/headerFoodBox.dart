import 'package:flutter/material.dart';
import 'styles.dart';

class HeaderFoodBox extends StatelessWidget {
  final String text;
  final String imageUrl;
  final GestureTapCallback onBack;
  HeaderFoodBox({@required this.text, @required this.onBack, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: MediaQuery.of(context).size.width,
        height: 210.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
          image: DecorationImage(
            image: imageUrl != ''
                ? NetworkImage(imageUrl)
                : AssetImage('assets/images/headerFoodBox.png'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0.8, 0.0),
            colors: [
              Color.fromRGBO(0, 0, 0, 0.46),
              Color.fromRGBO(0, 0, 0, 0.63)
            ],
            tileMode: TileMode.repeated,
          ),
        ),
        child: SafeArea(
            left: false,
            right: false,
            bottom: false,
            child: Expanded(
                child: Center(
                    child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.symmetric(vertical: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Material(
                      child: InkWell(
                    onTap: onBack,
                    child: Container(
                      child: Image.asset('assets/images/whiteBack.png',
                          width: 110.0, height: 110.0),
                    ),
                  )),
                  Text(text, style: foodNameStyle)
                ],
              ),
            )))));
  }
}
