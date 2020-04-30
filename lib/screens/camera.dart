import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter/scheduler.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ffo/screens/imagePreview.dart';
import 'package:ffo/components/Header/CancelHeader/transparentHeader.dart';

List<CameraDescription> cameras;

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription> cameras;
  bool isReady = false;
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
  bool showCapturedPhoto = false;
  bool hideModal = false;
  var imagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    SchedulerBinding.instance.addPostFrameCallback((_) => showTips( this.context));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    super.dispose();
  }

  void onCaptureButtonPressed(context) async {
    //on camera button press
    try {
      final path = join(
        (await getTemporaryDirectory()).path, //Temporary path
        '${DateTime.now()}.png',
      );
      imagePath = path;
      await _controller.takePicture(path); //take photo

      setState(() {
        showCapturedPhoto = true;
      });
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: ImagePreview(path: path)));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller != null
          ? _initializeControllerFuture = _controller.initialize()
          : null; //on pause camera is disposed, so we need to call again "issue is only for android"
    }
  }

  showTips(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
             // height: 300.0,
              width: MediaQuery.of(context).size.width *0.90,
              decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.all( Radius.circular(32.0)),
        //      borderRadius: BorderRadius.circular(15.0)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Before you scan',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
      bottom: BorderSide( //                   <--- left side
        color: Colors.grey,
        width: 0.5,
      ),
    ),
                      ),
                      child: Text(
                          '1) Please make sure your hands doesnt interfere with the picture being snapped',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w300)),
                    ),
                    Container(
              //        margin: EdgeInsets.symmetric(vertical: 10.0),
                      
                      decoration: BoxDecoration(
                        color: Colors.white,
                        
                                          border: Border(
      bottom: BorderSide( //                   <--- left side
        color: Colors.grey,
        width: 0.5,
      ),
    ),
                      ),
                      child: Text(
                          '2) Please try to take the picture in a well lighted area for better accuracy',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w300)),
                    ),
                    Container(
                  //    margin: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                                             border: Border(
      bottom: BorderSide( //                   <--- left side
        color: Colors.grey,
        width: 0.5,
      ),
    ),
                      ),
                      child: Text(
                          '3) For any known mistakes in our food ingredient prediction, kindly assist us by entering the correct name, Let\'s make this app better 😃',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w300)),
                    ),
                    ButtonTheme(
  minWidth: MediaQuery.of(context).size.width *0.85,
  height: 60.0,
  child:RaisedButton(
     shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(32.0))),
                      color: const Color(0xffEF383F),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'GOT IT!',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ))
                  ]),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              alignment: FractionalOffset.center,
              children: <Widget>[
                new Positioned.fill(
                    child: new AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: CameraPreview(_controller))),
                new Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  width: 90.0,
                  height: 90.0,
                  child: new GestureDetector(
                      onTap: () => onCaptureButtonPressed(context),
                      child: Image.asset(
                        'assets/images/capture.png',
                        fit: BoxFit.contain,
                      )),
                ),
                  new Positioned(
                  top: MediaQuery.of(context).size.height * 0.04,
                  child: TransparentHeader(isRecognized: false),
                ),
              ],
            );
          } else {
            return Center(
                child:
                    CircularProgressIndicator(
                                              backgroundColor:
                                                  const Color(0xffEF383F),
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                          Color>(
                                                      const Color(0xffFBAE17)),
                                            )); // Otherwise, display a loading indicator.
          }
        });
  }
}
