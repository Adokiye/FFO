import 'package:flutter/material.dart';
import '../components/FoodBox/HeaderFoodBox/headerFoodBox.dart';
import '../components/MenuBar/menuBar.dart';
import '../components/Text/RecipeText/recipeText.dart';

class RecipeDetails extends StatefulWidget {
  RecipeDetails({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
    bool recipe = false;
    bool ingredients =  false;
  _recipe() {
  setState(() {
    ingredients = false;
    recipe = true;
  });
}
  _ingredients() {
  setState(() {
    ingredients = true;
    recipe = false;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Expanded(child: Column(children: <Widget>[
        HeaderFoodBox(text: 'Jollof Rice', onBack: null),
        MenuBar(recipe: _recipe(), ingredients: _ingredients(),),
        recipe ? RecipeText(text: 'Heat about 4 tablespoons of canola oil and butter in a medium sized pot on medium heat and throw in some chopped red onions. Allow the onions to fry until the redness starts to slightly fade off.Next, pour in your tomato paste and let it fry with the onions. Make sure to stir the paste consistently to avoid burning. Do this for about 10 mins, or until the paste fully fries in the oil. Add in your crayfish for an extra tasty flavor.Blend some tomatoes, onions, habanero peppers, and red bell peppers together until you achieve a smooth consistency.Pour in the blended mixture into the pot and fry it together with the tomato paste.Add all your spices (BUT DON’T ADD SALT YET) and mix. Cover the pot and allow the tomato to fry in the oil. Add more oil if necessary. You really want to let the tomato fry to remove the slappy sour taste, so make sure you don’t rush this process. I would recommend letting it fry for about 20-30 mins. Be sure to continuously stir the mixture to avoid burning.')
          : RecipeText(text: 'Rice, oil, tomato paste')    ],),),
    );
  }
}
