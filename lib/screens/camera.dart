import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription> cameras;
  CameraController controller;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    setupCameras();
  }

  Future<void> setupCameras() async {
    try {
      cameras = await availableCameras();
      controller = new CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();
    } on CameraException catch (_) {
      setState(() {
        isReady = false;
      });
    }
    setState(() {
      isReady = true;
    });
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
