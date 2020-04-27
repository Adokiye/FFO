import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

List<CameraDescription> cameras;

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription> cameras;
  CameraController controller;
  bool isReady = false;
  Future<void> _initializeControllerFuture;
  bool showCapturedPhoto = false;
  var imagePath;

  @override
  void initState() {
    super.initState();
    setupCameras();
  }

  void onCaptureButtonPressed() async {
    //on camera button press
    try {
      final path = join(
        (await getTemporaryDirectory()).path, //Temporary path
        'ing-${DateTime.now()}.png',
      );
      imagePath = path;
      await controller.takePicture(path); //take photo

      setState(() {
        showCapturedPhoto = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> setupCameras() async {
    try {
      cameras = await availableCameras();
      controller = new CameraController(cameras[0], ResolutionPreset.high);
      _initializeControllerFuture = controller.initialize();
    } on CameraException catch (_) {
      setState(() {
        isReady = false;
      });
    }
    setState(() {
      isReady = true;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller != null
          ? _initializeControllerFuture = controller.initialize()
          : null; //on pause camera is disposed, so we need to call again "issue is only for android"
    }
  }

  showCustomDialogWithImage(BuildContext context) {
    Dialog dialogWithImage = Dialog(
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('TIPS',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
              Container(
                color: Colors.white,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.grey),
                ),
                child: Text(
                    '1) Please make sure your hands doesnt interfere with the picture being snapped',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ),
              Container(
                color: Colors.white,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.grey),
                ),
                child: Text(
                    '2) Please try to take the picture in a well lighted area for better accuracy',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ),
              Container(
                color: Colors.white,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.grey),
                ),
                child: Text(
                    '3) For any known mistakes in our food ingredient prediction, please assist us by entering the correct name to make this app better for everyone 😃',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ),
              RaisedButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel!',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              )
            ]),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => dialogWithImage);
  }

  Widget build(BuildContext context) {
    if (!isReady && !controller.value.isInitialized) {
      return Container();
    }
    return new Stack(
      alignment: FractionalOffset.center,
      children: <Widget>[
        new Positioned.fill(
          child: showCapturedPhoto
              ? new AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: new CameraPreview(controller))
              : t,
        ),
        new GestureDetector(
          onTap: () => onCaptureButtonPressed(),
          child: new Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            width: 104.0,
            height: 104.0,
            child: new Image.asset(
              'assets/images/capture.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        new Align(
          alignment: Alignment.bottomCenter,
          child: this.showCustomDialogWithImage(context),
        )
      ],
    );
  }
}
