import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:ffo/components/Header/CancelHeader/transparentHeader.dart';
import 'package:ffo/models/singleIngredient.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ffo/helpers/showUp.dart';
import '../components/Button/YellowButton/yellowButton.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ffo/screens/notFound.dart';
import 'package:ffo/screens/home.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:intl/intl.dart';
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
  String newName = 'Onions';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<SingleIngredient> fetchPost(context) async {
    final response = await http.get('http://test');
    if (response.statusCode == 200) {
      print('Received data');
      return SingleIngredient.fromJson(json.decode(response.body));
    } else {
      setState(() {
        isRecognized = false;
      });
         Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.downToUp,
              child: NotFound(header: 'Ingredient not recognized', 
              subText: 'Try taking a clearer picture',)
));
      throw Exception('Failed to load data');
    }
  }
    _addIngredient(name) async {
    DateTime now = DateTime.now();
    setState(() {
      showLoader = true;
    });
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    CloudinaryClient client = new CloudinaryClient(
        '892238245892288', '_qf4GlSi4m1TQOd44N_V5lHJKq0', 'gorge');
    await client
        .uploadImage(widget.path,
            filename: name + formattedDate, folder: 'ffo')
        .then((result) {
      print("CLOUDINARY:: ${result.secure_url}==> result");
      setState(() {
      showLoader = false;
    });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            name: name,
          ),
        ),
      );
    }).catchError((error) => {
      
       Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            name: name,
          ),
        ),
      )
      
     } );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
        body: new Stack(
              alignment: FractionalOffset.center,
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
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.0),
                        Color.fromRGBO(0, 0, 0, 0.87)
                      ],
                      stops: [
                        0.0,
                        1.0
                      ])),
            ),
          ),
          new Positioned(
            top: MediaQuery.of(context).size.height * 0.04,
            child: Center(child: TransparentHeader(isRecognized: true)),
          ),
          // new Positioned(
          //   bottom: MediaQuery.of(context).size.height * 0.05,
          //   right: 12.0,
          //   width: 70.0,
          //   height: 70.0,
          //   child: new GestureDetector(
          //       onTap: () => fetchPost(context).then((value) {
          //             setState(() {
          //               newName = value.name;
          //               isRecognized = true;
          //             });
          //           }),
          //       child: Image.asset(
          //         'assets/images/send.png',
          //         fit: BoxFit.contain,
          //       )),
          // ),
          new Positioned(
            bottom: MediaQuery.of(context).size.height * 0.07,
            child: ShowUp(
              child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),
                      child: Text(newName,
                          style: TextStyle(
                              color: Colors.white,
                            fontSize: 30,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: YellowButton(
                          text: 'ADD',
                          onPressed: () => _addIngredient(newName)
                        )),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                      margin: EdgeInsets.only(top: 14.0),
                      child: Text("Wrong Ingredient?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                    ))
                  ]),
              delay: 1000,
            ),
          ),
                    this.showLoader
              ? new Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    backgroundColor: const Color(0xffEF383F),
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        const Color(0xffFBAE17)),
                  ))
              : Container(),
        ]));
  }
}
