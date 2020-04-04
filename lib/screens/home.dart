import 'package:flutter/material.dart';
import 'dart:async';
import '../components/Text/HeaderText/headerText.dart';
import '../components/Button/ScanButton/scanButton.dart';
import '../components/TextInput/SearchTextInput/searchTextInput.dart';
import '../components/Button/YellowButton/yellowButton.dart';
import '../components/FoodBox/AddFoodBox/addFoodBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffo/helpers/firebase.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> ingredients;
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  StreamSubscription<QuerySnapshot> ingredientsSub;

  @override
  void initState() {
    super.initState();
 
    items = new List();
 
    ingredientsSub?.cancel();
    ingredientsSub = db.getNoteList().listen((QuerySnapshot snapshot) {
      final List<Note> notes = snapshot.documents
          .map((documentSnapshot) => Note.fromMap(documentSnapshot.data))
          .toList();
 
      setState(() {
        this.items = notes;
      });
    });
  }
 
  @override
  void dispose() {
    ingredientsSub?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(children: <Widget>[
        SingleChildScrollView(
            child: Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
              HeaderText(
                text: 'Add your ingredients',
              ),
              HeaderText(
                text: 'Find your perfect recipe. ',
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 36.0),
                  child: ScanButton(
                    onPressed: null,
                  )),
              SearchTextInput(),
              AddFoodBox(text: 'Tomato',onPressed: null,),
              AddFoodBox(text: 'Tomato Paste',onPressed: null,)
            ]))),
        Positioned(
            bottom: 40,
            child: YellowButton(
              text: 'COOK',
              onPressed: null,
            ))
      ])),
    );
  }
    void getData() {
    databaseReference
        .collection("ingredients")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }
}
