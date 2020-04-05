import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'styles.dart';

class RecipeFoodBox extends StatelessWidget {
  final String text;
  final String time;
  final String imageUrl;
  final GestureTapCallback onPressed;
  RecipeFoodBox(
      {@required this.text,
      @required this.onPressed,
      @required this.time,
      this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return new Align(
        alignment: Alignment.center,
        child:Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 100.0,
           decoration: boxDecorationStyle,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        margin: EdgeInsets.symmetric(vertical: 12.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            imageUrl != ''
                ?  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    height: 90.0,
                    width: 80.0,
                    decoration: imageDecorationStyle,
                    child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: imageUrl,
                  ))
                : Container(),
            Expanded
            (child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: imageUrl != '' ? CrossAxisAlignment.start:CrossAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Text(text, style: foodNameStyle),
                Spacer(),
                Row(children: <Widget>[
                  imageUrl == '' ? Spacer() : Container(),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        time,
                        style: subTextStyle,
                      )),
                  Image.asset(
                    'assets/images/clock.png',
                    height: 18,
                    width: 18,
                    fit: BoxFit.contain,
                  ),
                  Spacer(),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        'View Details',
                        style: subTextStyle,
                      )),
                  Image.asset(
                    'assets/images/next.png',
                    height: 18,
                    width: 18,
                    fit: BoxFit.contain,
                  ),
                  Spacer(),
                ]),
                Spacer(),
             
              ],
             ) )
          ],
        ),
     ) );
  }
}
