import 'package:flutter/material.dart';
import 'styles.dart';

class HeaderFoodBox extends StatelessWidget {
  final String text;
  final String imageUrl;
  final GestureTapCallback onBack;
  HeaderFoodBox({@required this.text, @required this.onBack, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return new    Stack(children: <Widget>[
    imageUrl != '' ?  Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageUrl != ''
                ? NetworkImage(imageUrl)
                : AssetImage('assets/images/headerFoodBox.png'),
            ),
          ),
          width: MediaQuery.of(context).size.width,
        height: 210.0,
        ) :  Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          width: MediaQuery.of(context).size.width,
        height: 210.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
        height: 210.0,
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                   colors: [
              Color.fromRGBO(0, 0, 0, 0.46),
              Color.fromRGBO(0, 0, 0, 0.63)
            ],
                  stops: [
                    0.0,
                    1.0
                  ])),
                  child: SafeArea(
            left: false,
            right: false,
            bottom: false,
            child: Center(
                    child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.symmetric(vertical: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new GestureDetector(
                    onTap: (){Navigator.pop(context);},
                    child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 26.0,
                        ),
                  ),
                  
                  
                  Text(text, style: foodNameStyle)
                ],
              ),
            )))
        )
      ]) 
        ;
  }
}
