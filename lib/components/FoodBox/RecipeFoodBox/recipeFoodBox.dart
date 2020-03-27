import 'package:flutter/material.dart';
import 'styles.dart';

class RecipeFoodBox extends StatelessWidget {
  final String text;
  final String time;
  final String imageUrl;
  final GestureTapCallback onPressed;
 RecipeFoodBox({@required this.text, @required this.onPressed, @required this.time, this.imageUrl});

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
            imageUrl != '' ? 
          CachedNetworkImage(
   imageUrl: imageUrl,
   placeholder: (context, url) => new CircularProgressIndicator(),
   errorWidget: (context, url, error) => new Icon(Icons.error),
 ) : Container(),
 Column(children: <Widget>[
   Text(text, style: foodNameStyle)
 ],)
        ],),
      ),
      onPressed: onPressed,
    );
  }
}
