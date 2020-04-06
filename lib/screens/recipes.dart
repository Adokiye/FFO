import 'package:flutter/material.dart';
import '../components/Text/HeaderText/headerText.dart';
import '../components/FoodBox/RecipeFoodBox/recipeFoodBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffo/helpers/firebase.dart';
import 'package:ffo/models/recipes.dart';
import 'package:ffo/screens/recipeDetails.dart';
import 'package:collection/collection.dart';
import 'package:ffo/models/ingredients.dart';
import 'package:ffo/screens/cooking.dart';
import 'package:flutter/services.dart';
import 'package:ffo/screens/notFound.dart';
import 'dart:async';
import 'package:ffo/helpers/enterExitRoute.dart';

class Recipes extends StatefulWidget {
  final List<String> ing;
  Recipes({Key key, this.title, @required this.ing}) : super(key: key);
  final String title;

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  List<RecipesModel> items;
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  StreamSubscription<QuerySnapshot> ingredientsSub;
  bool isRecipe = false;
  bool cooking = true;
  @override
  void initState() {
    super.initState();
   
    items = new List();
    ingredientsSub?.cancel();
    ingredientsSub = db.getRecipesList().listen((QuerySnapshot snapshot) {
        if(cooking){
          setState(() {
         cooking = false; 
        });
        }
            final List<RecipesModel> recs = snapshot.documents
          .map(
              (documentSnapshot) => RecipesModel.fromMap(documentSnapshot.data))
          .toList();
          this.items.clear();
      outLoop:
      for (var i = 0; i < (recs.length); i++) {
        inLoop:
        for (var j = 0; j < (recs[i].ingredients.length); j++) {
          if (widget.ing
              .toString()
              .toLowerCase()
              .contains(recs[i].ingredients[j].name.toString().toLowerCase())) {
            setState(() {
              this.items.add(recs[i]);
            });
            continue outLoop;
          }
        }
      }
      if(this.items.isEmpty){
        setState(() {
         isRecipe = false; 
        });
      }else{
        setState(() {
         isRecipe = true; 
        });
      }
    });
   
  }

  @override
  void dispose() {
    ingredientsSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if(cooking && !isRecipe){
      child = Cooking();
    }else if(!cooking && !isRecipe){
      child = NotFound(header: 'No Recipes Found', subText: 'Try choosing other ingredients',);
    }else{
      child = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          //  mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.075),
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
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.075),
                      margin: EdgeInsets.only(bottom: 15.0),
                  child: HeaderText(
                    text: 'Recipes Found',
                  )),
           items.isNotEmpty ? Expanded(
           //  constraints: BoxConstraints.expand(),
             child: Center(
                child:ListView.builder(
              scrollDirection: Axis.vertical,
  //  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                 //   print(items[index]);
                    return new GestureDetector(
                      onTap: (){
                         Navigator.push(
                  context,
               //    EnterExitRoute(exitPage: this, enterPage: Recipes(ing: chosenNames, title: 'Recipes')));
                  MaterialPageRoute(
                    builder: (context) => RecipeDetails(data: items[index]),
                  ),
                );
                      },
                      
                      child:  RecipeFoodBox(
                      text: items[index].name,
                      onPressed: null,
                      time: '20mins ',
                      imageUrl: items[index].image,
                      ));
                  }))):Container(),
                  ],
                );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: child
              )
              
            );
  }
}
