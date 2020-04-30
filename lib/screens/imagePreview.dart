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
import 'package:ffo/screens/retry.dart';
import 'package:ffo/screens/home.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

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
   
     var path = '/storage/emulated/0/DCIM/Camera/IMG_20200430_041702.jpg';
 String base64Image = base64Encode(File(widget.path).readAsBytesSync());
    http.post('https://sele-demo.herokuapp.com/api/postImage', body: {
      "image": [base64Image],
    }).then((result) {
      print(result.body.toString());
    }).catchError((error) {
     print(error.toString());
    });
//    try{
//       Response response;
// Dio dio = new Dio();
// //dio.options.baseUrl = "http://159.65.45.231";
// dio.options.baseUrl = "https://sele-demo.herokuapp.com";
//   setState(() {
//       showLoader = true;
//     });
//    FormData formData = new FormData.fromMap({
//    "image": http.MultipartFile.fromPath("image",path,filename:path.split("/").last,
//    contentType: new MediaType(
//             'image',
//             'jpg',
//           ))
// });
// print(formData.fields[0].toString()+"dssd");
// response = await dio.post("/api/postImage", data: formData,   
// options: Options(
//             followRedirects: false,
//             validateStatus: (status) {
//               return status < 500;
//             },
//             headers: {
//            "Content-Type": "multipart/form-data",
//            "X-Requested-With":  "XMLHttpRequest"
//          }
//           ),
          
//           );
//           print(response.toString());
//    }    on DioError catch(e) {
//       print(e.response.data);
//       print(e.response.headers);
//       print(e.response.request);
//     }


  //   // open a bytestream
  //     var stream = new http.ByteStream(DelegatingStream.typed(File(widget.path).openRead()));
  //   //create multipart request for POST or PATCH method
  //   var request = http.MultipartRequest(
  //       "POST", Uri.parse("http://159.65.45.231/predict/"));
  //   //create multipart using filepath, string or bytes
  // //  var pic = await http.MultipartFile.fromPath("file_field", widget.path);
  //   // multipart that takes file
  //     // var multipartFile = new http.MultipartFile('file', stream, 1,
  //     //     filename: basename(widget.path));
  //   //add multipart to request
  //  // request.files.add(multipartFile);
  //  request.files.add(await http.MultipartFile.fromPath(
  //     'picture', widget.path, filename: widget.path.split("/").last,
  //     contentType: MediaType('image', '')));
  //   var response = await request.send();
  //   //Get the response from the server
  //   var responseData = await response.stream.toBytes();
  //   var responseString = String.fromCharCodes(responseData);
  //   print(responseString);
  //   //print(responseString.)
  //   if (response.statusCode == 200) {
  //     print('Received data');
  //       setState(() {
  //     showLoader = false;
  //   });
  //     if(SingleIngredient.fromJson(json.decode(responseString)).name != null ){
  //        setState(() {
  //       newName = SingleIngredient.fromJson(json.decode(responseString)).name;
  //     });
  //     }else{
  //        setState(() {
  //       isRecognized = false;
  //       showLoader = false;
  //     });
  //        Navigator.push(
  //         context,
  //         PageTransition(
  //             type: PageTransitionType.downToUp,
  //             child: Retry(
  //               header: 'Ingredient not recognized',
  //               subText: 'Try taking a clearer picture',
  //             )));
  //     }
     
  //   } else {
  //     setState(() {
  //       isRecognized = false;
  //     });
  //     Navigator.push(
  //         context,
  //         PageTransition(
  //             type: PageTransitionType.downToUp,
  //             child: Retry(
  //               header: 'Ingredient not recognized',
  //               subText: 'Try taking a clearer picture',
  //             )));
  //     throw Exception('Failed to load data');
  //   }
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
       newName != null ?   new Positioned(
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
          ):Container(),
          new Positioned(
            top: MediaQuery.of(context).size.height * 0.04,
            child: Center(child: TransparentHeader(isRecognized: newName != null?true:false)),
          ),
          new Positioned(
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
          ),
          newName!= null
              ? new Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.07,
                  child: ShowUp(
                    child: Column(children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.01),
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
                              onPressed: () => _addIngredient(newName, context))),
                      GestureDetector(
                          onTap: () {},
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
