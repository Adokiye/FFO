import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:ffo/components/Header/CancelHeader/transparentHeader.dart';
import 'package:ffo/models/singleIngredient.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ImagePreview extends StatefulWidget {
  final String path;
  ImagePreview({
    @required this.path,
  });

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  bool showLoader = false;
  bool isRecognized = false;
  String newName;
  Future<SingleIngredient> fetchPost() async {
    final response = await http.get('http://mywebserviceurl');
    if (response.statusCode == 200) {
      print('Received data');
      return SingleIngredient.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
            //  alignment: FractionalOffset.center,
            children: <Widget>[
          new Positioned.fill(
            child: Image.file(
              File(widget.path),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          new Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            right: 12.0,
            width: 70.0,
            height: 70.0,
            child: new GestureDetector(
                onTap: () => fetchPost().then((value) {
                      setState(() {
                        newName = value.name;
                      });
                    }),
                child: Image.asset(
                  'assets/images/send.png',
                  fit: BoxFit.contain,
                )),
          ),
          this.showLoader ??
              new Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    backgroundColor: const Color(0xffEF383F),
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        const Color(0xffFBAE17)),
                  )),
          new Positioned(
            top: MediaQuery.of(context).size.height * 0.04,
            child: Center(child: TransparentHeader(isRecognized: isRecognized)),
          ),
        ]));
  }
}
