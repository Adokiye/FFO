import 'package:flutter/material.dart';
import '../components/Text/HeaderText/headerText.dart';
import '../components/FoodBox/RecipeFoodBox/recipeFoodBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffo/helpers/firebase.dart';
import 'package:ffo/models/recipes.dart';
import 'package:flutter/services.dart';
import 'dart:async';
class Recipes extends StatefulWidget {
  final List<String> ing;
    Recipes({Key key, this.title, @required this.ing}) : super(key: key);
  final String title;

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  List<Recipes> items;
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  StreamSubscription<QuerySnapshot> ingredientsSub;
    @override
  void initState() {
    super.initState();
    items = new List();
    ingredientsSub?.cancel();
    ingredientsSub = db.getRecipesList().listen((QuerySnapshot snapshot) {
      final List<Recipes> recs = snapshot.documents
          .map((documentSnapshot) => Recipes.fromMap(documentSnapshot.data))
          .toList();
          widget.ing.forEach((item) => recs
          .where((itemM) =>
              itemM.ingredients.name.toString().toLowerCase().contains(item.toLowerCase()))
          .toList();
      setState(() {
        this.items = recs
          .where((item) =>
              item.ingredients.name.toString().toLowerCase().contains(recs.ingredients.name.toLowerCase()))
          .toList();
        
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
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[
                Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075),
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                    child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: const Color(0xffEF383F),
                          size: 24.0,
                        ))),
            ),
            Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075),
            child: HeaderText(text: 'Recipes Found',)),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: RecipeFoodBox(text: 'Jollof Rice', onPressed: null, time: '20mins',imageUrl: '',)
              )],),
            )
            ]
          ),),
    );
  }
}
