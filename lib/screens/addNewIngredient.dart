import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/Text/HeaderText/headerText.dart';
import '../components/Text/LightText/lightText.dart';
import '../components/Header/CancelHeader/cancelHeader.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'dart:io';
import 'package:ffo/models/ingredients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:ffo/helpers/firebase.dart';
import 'package:ffo/screens/home.dart';
import 'package:intl/intl.dart';

class AddNewIngredient extends StatefulWidget {
  final String path;
  AddNewIngredient({
    @required this.path,
  });

  @override
  _AddNewIngredientState createState() => _AddNewIngredientState();
}

class _AddNewIngredientState extends State<AddNewIngredient> {
  final textController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Ingredients> items;
  bool showLoader = false;
  _addIngredient(name) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    CloudinaryClient client = new CloudinaryClient(
        '892238245892288', '_qf4GlSi4m1TQOd44N_V5lHJKq0', 'gorge');
    setState(() {
      showLoader = true;
    });
    await client
        .uploadImage(widget.path,
            filename: name + formattedDate, folder: 'unfilteredIngredients')
        .then((result) {
      print("CLOUDINARY:: ${result.secure_url}==> result");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            name: name,
          ),
        ),
      );
    }).catchError((error) =>
            //  print("ERROR_CLOUDINARY::  $error");
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Upload failed',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  )),
              action: SnackBarAction(
                label: 'RETRY',
                textColor: const Color(0xffEF383F),
                onPressed: () {
                  _addIngredient(name);
                },
              ),
              duration: Duration(seconds: 3),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
            CancelHeader(),
            Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.04,
                        bottom: 12.0),
                    child: HeaderText(
                      text: 'Add Ingredient',
                    ))),
            Center(
                child: Image.file(
              File(widget.path),
              fit: BoxFit.cover,
              height: 140,
              width: MediaQuery.of(context).size.width * 0.85,
              alignment: Alignment.center,
            )),
            Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: EdgeInsets.only(top: 12.0),
                    child: LightText(
                      text:
                          'Add this ingredient to our database for better identification later on. For Food Only\'s Nigerian ingredients model still has a lot to learn and with your help it can get smarter 😉.',
                    ))),
            this.showLoader
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: const Color(0xffEF383F),
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        const Color(0xffFBAE17)),
                  ))
                : Container(),
          ])),
    );
  }
}
