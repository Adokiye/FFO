import 'package:flutter/material.dart';
import 'dart:async';
import '../components/Text/HeaderText/headerText.dart';
import '../components/Button/ScanButton/scanButton.dart';
import '../components/TextInput/SearchTextInput/styles.dart';
import '../components/Button/YellowButton/yellowButton.dart';
import '../components/FoodBox/AddFoodBox/addFoodBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffo/helpers/firebase.dart';
import 'package:ffo/models/ingredients.dart';
import '../components/FoodBox/AddedFoodBox/addedFoodBox.dart';
import 'package:ffo/screens/recipes.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Ingredients> items;
  List<Ingredients> newItems;
  List<Ingredients> chosenItems = List<Ingredients>();
  List<String> chosenNames = List<String>();
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  StreamSubscription<QuerySnapshot> ingredientsSub;
  final textController = TextEditingController();

  _setChosen(Ingredients ingredient) {
    print(ingredient);
    setState((){
       chosenItems.add(ingredient);
    chosenNames.add(ingredient.name);
    newItems = new List();
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
    textController.addListener(_textListener);
  }

  @override
  void dispose() {
    ingredientsSub?.cancel();
    super.dispose();
    textController.dispose();
  }
    _textListener() {
     // print(newItems.length);
    setState(() {
      newItems = items
          .where((item) =>
              item.name.toString().contains(this.textController.text))
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
            child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: <Widget>[SingleChildScrollView(
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: <Widget>[
                      Center(child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: HeaderText(
                text: 'Add your ingredients',
              ),)),
              Center(child: HeaderText(
                text: 'Find your perfect recipe. ',
              ),),
              Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075) ,
                margin: EdgeInsets.symmetric(vertical: 18.0),
              child: ScanButton(
                    onPressed: null,
                  ))
              ,
              Center(
                child: Material(
        elevation: 3.0,
        shadowColor: Color.fromRGBO(0, 0, 0, 0.14),
        child: Container(
          width:  MediaQuery.of(context).size.width * 0.85,
          height: 51.0,
          child: TextField(
            controller: textController,
            style: enteredTextStyle1,
          decoration: inputDecoration1,
          keyboardType: TextInputType.text,
        )))),
            textController.text != '' ?  ListView.builder(
              scrollDirection: Axis.vertical,
    shrinkWrap: true,
                  itemCount: newItems.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    print(newItems[index]);
                    return new Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: AddFoodBox(
                      text: newItems[index].name,
                      onPressed: null, //_setChosen(newItems[index]),
                    ));
                  }):Container(),
            chosenNames.length >0 ?  ListView.builder(
              scrollDirection: Axis.vertical,
    shrinkWrap: true,
                  itemCount: chosenItems.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return new AddedFoodBox(
                      text: newItems[index].name,
                      imageUrl: chosenItems[index].image,
                      onPressed: null,
                    );
                  }):Container()
            ])),
     Positioned(
            bottom: 40,
            left: MediaQuery.of(context).size.width*0.075,
            child: Align(
              alignment: Alignment.center,
              child: YellowButton(
              text: 'COOK',
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Recipes(ing: chosenNames, title: 'Recipes'),
                //   ),
                // );
              },
       )  ))
      ])),
        
        )
     ) );
  }
}
