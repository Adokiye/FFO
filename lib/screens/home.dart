import 'package:flutter/material.dart';
import 'dart:async';
import '../components/Text/HeaderText/headerText.dart';
import '../components/Button/ScanButton/scanButton.dart';
import '../components/TextInput/SearchTextInput/searchTextInput.dart';
import '../components/Button/YellowButton/yellowButton.dart';
import '../components/FoodBox/AddFoodBox/addFoodBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffo/helpers/firebase.dart';
import 'package:ffo/models/ingredients.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Ingredients> items;
  List<Ingredients> newItems;
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  StreamSubscription<QuerySnapshot> ingredientsSub;
  TextEditingController textController;
     textListener() {
       print(textController.text);
        setState(() {
        this.newItems = items.where((item) => item.name.toString().split(" ").contains(textController.text)).toList();  
      });
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
    textController.addListener(textListener);
  }
 
  @override
  void dispose() {
    ingredientsSub?.cancel();
    super.dispose();
    textController.dispose();
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
              SearchTextInput(textController: this.textController,),
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
