import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

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

  void onCaptureButtonPressed() async {  //on camera button press
  try {

    final path = join(
      (await getTemporaryDirectory()).path, //Temporary path
      '$pageStatus${DateTime.now()}.png',
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

  Widget build(BuildContext context) {
    if (!isReady && !controller.value.isInitialized) {
      return Container();
    }
    return new Stack(
  alignment: FractionalOffset.center,
  children: <Widget>[
    new Positioned.fill(
      child: new AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: new CameraPreview(controller)),
    ),
    new Positioned(
      bottom: 10.0,
      width: 40.0,
      height: 40.0,
      child: new Opacity(
        opacity: 0.3,
        child: new Image.network(
          'https://picsum.photos/3000/4000',
          fit: BoxFit.fill,
        ),
      ),
    ),
  ],
);
  }
}
