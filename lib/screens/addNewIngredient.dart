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
import 'dart:async';
import '../components/FoodBox/AddFoodBox/addFoodBox.dart';
import '../components/FoodBox/AddedFoodBox/addedFoodBox.dart';

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
  List<Ingredients> newItems;
  List<Ingredients> chosenItems = List<Ingredients>();

  bool showLoader = false;
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  StreamSubscription<QuerySnapshot> ingredientsSub;
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
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            name: name,
          ),
        ),
        (Route<dynamic> route) => false
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
  void initState() {
    super.initState();
    items = new List();
    ingredientsSub?.cancel();
    ingredientsSub = db.getIngredientsList().listen((QuerySnapshot snapshot) {
      final List<Ingredients> ings = snapshot.documents
          .map((documentSnapshot) => Ingredients.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.items = ings;
      });
    });
    textController.addListener(_textListener);
    if (this.items.isEmpty) {
      _asyncMethod();
    }
  }

  @override
  void dispose() {
    ingredientsSub?.cancel();
    super.dispose();
    textController.dispose();
  }

  _removeChosen(index) {
    setState(() {
      if (chosenItems.isNotEmpty) {
        items.add(chosenItems[index]);
      }
      print(items.length);
      chosenItems.removeAt(index);
    });
  }

  _setChosen(Ingredients ingredient) {
    print(ingredient.name);
    var check =
        chosenItems.where((item) => item.name == ingredient.name).toList();
    if (check.isEmpty) {
      setState(() {
        chosenItems.add(ingredient);
        items.removeWhere((itemM) => itemM.name == ingredient.name);
        newItems = new List();
        textController.clear();
        FocusScope.of(context).unfocus();
        _addIngredient(ingredient.name);
      });
    }
  }

  _asyncMethod() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('No Internet Connection',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            )),
        // duration: Duration(seconds: 3),
      ));
    }
  }

  _textListener() {
    setState(() {
      //chosenItems.forEach((item) => items.removeWhere((itemM)=> itemM.name == item.name));
      print(items.length);
      newItems = items
          .where((item) => item.name
              .toString()
              .toLowerCase()
              .contains(this.textController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: SafeArea(
          child:   SingleChildScrollView(
                              child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
            CancelHeader(),
            Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
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
                    margin: EdgeInsets.only(bottom: 12.0),
                    padding: EdgeInsets.only(top: 12.0),
                    child: LightText(
                      text:
                          'Add this ingredient to our database for better identification later on.',
                    ))),
            this.showLoader
                ? Center(
                    child: Container(
                                            margin: EdgeInsets.only(
                                                top: 10.0, bottom: 10.0),
                                            child:CircularProgressIndicator(
                    backgroundColor: const Color(0xffEF383F),
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        const Color(0xffFBAE17)),
                   )   ))
                : Container(),
           Center(
             child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextField(
              controller: textController,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Enter ingredient name',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.0,
                  color: const Color(0xff979797),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xffDCE0E7), width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xffEF383F), width: 1.0),
                ),
                fillColor: const Color(0xfffafafb),
                filled: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: const Color(0xffEF383F),
                  size: 25.0,
                ),
              ),
              keyboardType: TextInputType.text,
             )  )  ),
            textController.text == '' && chosenItems.isEmpty && items.isNotEmpty
                ? Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return new GestureDetector(
                                  onTap: () => _setChosen(items[index]),
                                  child: AddFoodBox(
                                    text: items[index].name,
                                  ));
                            })))
                : Container(),
            textController.text != ''
                ? Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: newItems.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              print(newItems[index]);
                              return new GestureDetector(
                                  onTap: () => _setChosen(newItems[index]),
                                  child: AddFoodBox(
                                    text: newItems[index].name,
                                  ));
                            })))
                : Container(),
            chosenItems.isNotEmpty
                ? Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: chosenItems.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return new AddedFoodBox(
                                text: chosenItems[index].name,
                                imageUrl: chosenItems[index].image,
                                onPressed: () => _removeChosen(index),
                              );
                            })))
                : Container()
          ]))),
    );
  }
}
