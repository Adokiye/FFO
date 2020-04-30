import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:ffo/components/Header/CancelHeader/transparentHeader.dart';
import 'package:ffo/models/singleIngredient.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ffo/helpers/showUp.dart';
import 'package:image_picker/image_picker.dart';
import '../components/Button/YellowButton/yellowButton.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ffo/screens/retry.dart';
import 'package:ffo/screens/home.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:ffo/screens/addNewIngredient.dart';

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
  File _image;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _addIngredient(name, context) async {
    DateTime now = DateTime.now();
    setState(() {
      showLoader = true;
    });
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    CloudinaryClient client = new CloudinaryClient(
        '892238245892288', '_qf4GlSi4m1TQOd44N_V5lHJKq0', 'gorge');
    await client
        .uploadImage(widget.path, filename: name + formattedDate, folder: 'ffo')
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
   //   print(error);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(
                    name: name,
                  ),
                ),
              )
            });
  }

  Future<SingleIngredient> _asyncFileUpload(context) async {
    var filename = widget.path.split('/').last;
    try {
      Response response;
      Dio dio = new Dio();
      setState(() {
        showLoader = true;
      });

      FormData data = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          widget.path,
          filename: filename,
        ),
      });
      response = await dio.post(
        "http://159.65.45.231/predict/",
        data: data,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            headers: {
              "Content-Type": "multipart/form-data",
              "X-Requested-With": "XMLHttpRequest"
            }),
      );
      print(response.data.toString() + "dgdg");
            if (response.statusCode == 200) {
        print('Received data');
          setState(() {
        showLoader = false;
      });
        if(SingleIngredient.fromJson(response.data).Prediction != null ){
             print(SingleIngredient.fromJson(response.data).Prediction);

           setState(() {
          newName = SingleIngredient.fromJson(response.data).Prediction;
          showLoader = false;
          isRecognized = false;

        });
        }else{
           setState(() {
          isRecognized = false;
          showLoader = false;
        });
           Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.downToUp,
                child: Retry(
                  header: 'Ingredient not recognized',
                  subText: 'Try taking a clearer picture',
                )));
        }
            }
    } on DioError catch (e) {
      print(e.response.data);
      print(e.response.headers);
      print(e.response.request);
         setState(() {
          isRecognized = false;
          showLoader = false;
        });
       Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.downToUp,
                child: Retry(
                  header: 'Ingredient not recognized',
                  subText: 'Try taking a clearer picture',
                )));
    }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        body: new Stack(alignment: FractionalOffset.center, children: <Widget>[
          new Positioned.fill(
            child: Image.file(
              File(widget.path),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          newName != null
              ? new Positioned(
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
                )
              : Container(),
          new Positioned(
            top: MediaQuery.of(context).size.height * 0.04,
            child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        child: TransparentHeader(
                    isRecognized: newName != null ? true : false)),
          ),
       newName == null
              ?   new Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            right: 12.0,
            width: 70.0,
            height: 70.0,
            child: new GestureDetector(
                onTap: () => this._asyncFileUpload(context),
                child: Image.asset(
                  'assets/images/send.png',
                  fit: BoxFit.contain,
                )),
          ):Container(),
          newName != null
              ? new Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.07,
                  child: ShowUp(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      
                      Container(
                        // margin: EdgeInsets.only(
                        //     left: MediaQuery.of(context).size.width * 0.01),
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
                              onPressed: () =>
                                  _addIngredient(newName, context))),
                      GestureDetector(
                          onTap: () {
                             Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: AddNewIngredient(
                  path: widget.path,
                )));
                          },
                         child: Container(
                           width: MediaQuery.of(context).size.width * 0.85,
                            margin: EdgeInsets.only(top: 14.0),
                            child: Center(
                              child:Text("Wrong Ingredient?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                )),
                         )   ))
                    ]),
                    delay: 1000,
                  ),
                )
              : Container(),
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
