import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'styles.dart';

class AddedFoodBox extends StatelessWidget {
  final String text;
  final String imageUrl;
  final GestureTapCallback onPressed;
  AddedFoodBox({@required this.text, @required this.onPressed, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 69.0,
        margin: EdgeInsets.only(top: 5.0),
        decoration: boxDecorationStyle,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                imageUrl != '' ?
                Container(
                    margin: EdgeInsets.only(right: 10.0),
                    height: 30.0,
                    width: 30.0,
                    child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: imageUrl,
                    height: 30.0,
                    width: 30.0,
                    fit: BoxFit.cover,
                  )): Container(),
                Text(
                  text,
                  style: foodNameStyle,
                ),
                Spacer(),
                Material(
                  color: Colors.transparent,
                    child: InkWell(
                        onTap: onPressed,
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: Icon(
                          Icons.delete,
                          color: const Color(0xffEF383F),
                          size: 20.0,
                 ) ) ))),
              ],
            )));
  }
}
