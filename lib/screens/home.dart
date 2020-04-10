import 'package:flutter/material.dart';
import 'dart:async';
import '../components/Text/HeaderText/headerText.dart';
import '../components/Button/ScanButton/scanButton.dart';
import '../components/TextInput/SearchTextInput/styles.dart';
import 'dart:io';
import '../components/Button/YellowButton/yellowButton.dart';
import '../components/FoodBox/AddFoodBox/addFoodBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffo/helpers/firebase.dart';
import 'package:ffo/models/ingredients.dart';
import 'package:flutter/services.dart';
import '../components/FoodBox/AddedFoodBox/addedFoodBox.dart';
import 'package:ffo/screens/recipes.dart';
import 'package:ffo/screens/camera.dart';
import 'package:ffo/screens/cooking.dart';
import 'package:ffo/helpers/enterExitRoute.dart';
import 'package:page_transition/page_transition.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Ingredients> items;
  List<Ingredients> newItems;
  bool cooking = false;
  List<Ingredients> chosenItems = List<Ingredients>();
  List<String> chosenNames = List<String>();
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  StreamSubscription<QuerySnapshot> ingredientsSub;
  final textController = TextEditingController();
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _setChosen(Ingredients ingredient) {
    print(ingredient.name);
      var check = chosenItems.where((item) => item.name == ingredient.name).toList();
      if(check.isEmpty){
        setState((){
chosenItems.add(ingredient);
    chosenNames.add(ingredient.name);
    newItems = new List();
    textController.clear();
    FocusScope.of(context).unfocus();
     }); 
      }
  }
  _removeChosen(index){
    setState((){
      if(chosenItems.isNotEmpty){
     //   items.add(chosenItems[index]);
      }
      print(items.length);
      chosenItems.removeAt(index);
      chosenNames.removeAt(index);
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
    if(this.items.isEmpty){
      _asyncMethod();
    }
  }

  @override
  void dispose() {
    ingredientsSub?.cancel();
    super.dispose();
    textController.dispose();
  }
    _textListener() {
    setState(() {
     // chosenItems.forEach((item) => items.removeWhere((itemM)=> itemM.name == item.name));
      print(items.length);
      newItems = items
          .where((item) =>
              item.name.toString().toLowerCase().contains(this.textController.text.toLowerCase()))
          .toList();
    });
  }

  _asyncMethod() async{
                     try {
  final result = await InternetAddress.lookup('example.com');
  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    print('connected');
  }
} on SocketException catch (_) {
  print('not connected');
  _scaffoldKey.currentState.showSnackBar(
  SnackBar(
    content: Text('No Internet Connection', style: TextStyle(fontFamily: 'Poppins',fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w300, )),
   // duration: Duration(seconds: 3),
  ));
}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: SafeArea(
          child: cooking ? Cooking() : Center(
            child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: <Widget>[SingleChildScrollView(
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075) ,
                        child: HeaderText(
                text: 'Add your ingredients',
              ),),
                       Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075) ,
                child: HeaderText(
                text: 'Find your perfect recipe. ' +'😉',
          )   ),
              Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075) ,
                margin: EdgeInsets.symmetric(vertical: 18.0),
              child: ScanButton(
                    onPressed: (){
                         Navigator.push(
                  context,
                PageTransition(type: PageTransitionType.rightToLeft, child: RecipeDetails(data: items[index])));
                      },
                  ))
              ,
              Center(
                child: Material(
        elevation: 3.0,
        shadowColor: Color.fromRGBO(0, 0, 0, 0.14),
        child: Container(
          width:  MediaQuery.of(context).size.width * 0.85,
          height: 51.0,
          child: Material(
              elevation: 6.5,
              shadowColor: Colors.black,
                          child:TextField(
            controller: textController,
            style: enteredTextStyle1,
          decoration: inputDecoration1,
          keyboardType: TextInputType.text,
        ))))),
        chosenItems.isEmpty && items.isEmpty ? 
        Center(child:
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child:CircularProgressIndicator(
            backgroundColor: const Color(0xffEF383F),
            valueColor: new AlwaysStoppedAnimation<Color>(const Color(0xffFBAE17)),
          ))):Container(),
        textController.text == '' && chosenItems.isEmpty && items.isNotEmpty ?  Center(
              child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: ListView.builder(
              scrollDirection: Axis.vertical,
    shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext ctxt, int index) {
                 //   print(items[index]);
                    return new GestureDetector(
                      onTap: () => _setChosen(items[index]),
                      child: AddFoodBox(
                      text: items[index].name, 
                    ));
                  }))):Container(),
            textController.text != '' ?  Center(
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
                  }))):Container(),
            chosenItems.isNotEmpty ?  Center(
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
                  }))):Container()
            ])),
            chosenItems.isNotEmpty && textController.text == '' ?
     Positioned(
            bottom: 30,
            left: MediaQuery.of(context).size.width*0.075,
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              child: YellowButton(
              text: 'COOK',
              onPressed: () {
                Navigator.push(
                  context,
                  EnterExitRoute(exitPage: MyHomePage(title: 'FFO'), enterPage: Recipes(ing: chosenNames, title: 'Recipes')));
                
              },
       )  )):Container()
      ])),
        
        )
     ) );
  }
}
