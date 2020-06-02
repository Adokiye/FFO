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
import 'package:provider/provider.dart';
import 'package:ffo/providers/chosenItems.dart';

class MyHomePage extends StatefulWidget {
MyHomePage({Key key, this.title, this.name}) : super(key: key);

  final String name;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Ingredients> chosenItems = List<Ingredients>();
  List<String> chosenNames = List<String>();
  bool cooking = false;
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  StreamSubscription<QuerySnapshot> ingredientsSub;
  List<Ingredients> items;
  List<Ingredients> newItems;
  final textController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    ingredientsSub?.cancel();
    super.dispose();
    textController.dispose();
  }

  @override
  void initState() {
    super.initState();
    items = new List();

    textController.addListener(_textListener);
    if (this.items.isEmpty) {
      _asyncMethod();
    }
   
  }

  _setChosen(Ingredients ingredient) {
    print(ingredient.name);
      Provider.of<ChosenItemsModel>(context, listen: false).add(ingredient);
      setState(() {
        newItems = new List();
        textController.clear();
        FocusScope.of(context).unfocus();
      });
  }


  _removeChosen(index) {
   Provider.of<ChosenItemsModel>(context,listen: false).removeItem(index);
  }

  _textListener() {
    setState(() {
      //chosenItems.forEach((item) => items.removeWhere((itemM)=> itemM.name == item.name));
      print(items.length);
      newItems = Provider.of<ChosenItemsModel>(context,listen: false).items
          .where((item) => item.name
              .toString()
              .toLowerCase()
              .contains(this.textController.text.toLowerCase()))
          .toList();
          
    });
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

  @override
  Widget build(BuildContext context) {
      final appState = Provider.of<ChosenItemsModel>(context);
      if(widget.name != null){
        var name = widget.name;
        print(name);
       var checkItems = appState.items.where((item) => item.name.toLowerCase() == name.toLowerCase()).toList();
    var check =
        appState.chosenItems.where((item) => item.name.toLowerCase().trim() == name.toLowerCase().trim()).toList();
    if (check.isEmpty) {
      appState.add(checkItems.elementAt(0));
      setState(() {
        newItems = new List();
        textController.clear();
        FocusScope.of(context).unfocus();
      });
    }else{
  //            _scaffoldKey.currentState.showSnackBar(
  // SnackBar(
  //   content: Text(name+ ' has already been added', 
  //   style: TextStyle(fontFamily: 'Poppins',fontSize: 15.0, 
  //   color: Colors.white, fontWeight: FontWeight.w300, ))
  //   ,
  //   behavior: SnackBarBehavior.floating,
  //   backgroundColor: const Color(0xffEF383F),
  //   elevation: 0.0,
  // ));
    }
  
      }
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SafeArea(
            child: cooking
                ? Cooking()
                : Center(
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(children: <Widget>[
                          SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.075),
                                  child: HeaderText(
                                    text: 'Add your ingredients',
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.075),
                                    child: HeaderText(
                                      text: 'Find your perfect recipe. ' + '😉',
                                    )),
                                Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.075),
                                    margin:
                                        EdgeInsets.symmetric(vertical: 18.0),
                                    child: ScanButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: Camera()));
                                      },
                                    )),
                                Center(
                                    child: Material(
                                        elevation: 3.0,
                                        shadowColor:
                                            Color.fromRGBO(0, 0, 0, 0.14),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            height: 51.0,
                                            child: Material(
                                                elevation: 6.5,
                                                shadowColor: Colors.black,
                                                child: TextField(
                                                  controller: textController,
                                                  style: enteredTextStyle1,
                                                  decoration: inputDecoration1,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ))))),
                                appState.chosenItems.isEmpty && appState.items.isEmpty
                                    ? Center(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                top: 10.0, bottom: 10.0),
                                            child: CircularProgressIndicator(
                                              backgroundColor:
                                                  const Color(0xffEF383F),
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                          Color>(
                                                      const Color(0xffFBAE17)),
                                            )))
                                    : Container(),
                                textController.text == '' &&
                                        appState.chosenItems.isEmpty &&
                                        appState.items.isNotEmpty
                                    ? Center(
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: 5,
                                                itemBuilder: (BuildContext ctxt,
                                                    int index) {
                                                  return new GestureDetector(
                                                      onTap: () => _setChosen(
                                                          appState.items[index]),
                                                      child: AddFoodBox(
                                                        text: appState.items[index].name,
                                                      ));
                                                })))
                                    : Container(),
                                textController.text != ''
                                    ? Center(
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: newItems.length,
                                                itemBuilder: (BuildContext ctxt,
                                                    int index) {
                                                  print(newItems[index]);
                                                  return new GestureDetector(
                                                      onTap: () => _setChosen(
                                                          newItems[index]),
                                                      child: AddFoodBox(
                                                        text: newItems[index]
                                                            .name,
                                                      ));
                                                })))
                                    : Container(),
                                appState.chosenItems.isNotEmpty
                                    ? Center(
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: appState.chosenItems.length,
                                                itemBuilder: (BuildContext ctxt,
                                                    int index) {
                                                  return new AddedFoodBox(
                                                    text:
                                                        appState.chosenItems[index].name,
                                                    imageUrl: appState.chosenItems[index]
                                                        .image,
                                                    onPressed: () =>
                                                        _removeChosen(index),
                                                  );
                                                })))
                                    : Container()
                              ])),
                          appState.chosenItems.isNotEmpty && textController.text == ''
                              ? Positioned(
                                  bottom: 30,
                                  left:
                                      MediaQuery.of(context).size.width * 0.075,
                                  child: Container(
                                      margin: EdgeInsets.only(top: 20.0),
                                      child: YellowButton(
                                        text: 'COOK',
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              EnterExitRoute(
                                                  exitPage:
                                                      MyHomePage(title: 'FFO'),
                                                  enterPage: Recipes(
                                                      ing: appState.chosenNames,
                                                      title: 'Recipes')));
                                        },
                                      )))
                              : Container()
                        ])),
                  )));
  }
}
