import 'package:flutter/material.dart';
import '../components/Text/HeaderText/headerText.dart';
import '../components/Button/ScanButton/scanButton.dart';
import '../components/TextInput/SearchTextInput/searchTextInput.dart';
import '../components/Button/YellowButton/yellowButton.dart';
import '../components/FoodBox/AddFoodBox/addFoodBox.dart';

class Recipes extends StatefulWidget {
  Recipes({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
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
            ]))),),
    );
  }
}
