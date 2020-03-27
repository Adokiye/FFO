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
    return new RawMaterialButton(
      fillColor: Color.fromRGBO(230, 230, 230, 0.5),
      // elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(6.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 100.0,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        margin: EdgeInsets.only(top: 25.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            imageUrl != ''
                ?  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    height: 80.0,
                    width: 80.0,
                    decoration: imageDecorationStyle,
                    child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: imageUrl,
                  ))
                : Container(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                Text(text, style: foodNameStyle),
                Spacer(),
                Row(children: <Widget>[
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
                    'assets/images/clock.png',
                    height: 18,
                    width: 18,
                    fit: BoxFit.contain,
                  ),
                  Spacer(),
                ])
              ],
            )
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
