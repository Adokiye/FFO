import 'package:flutter/material.dart';
import '../components/FoodBox/HeaderFoodBox/headerFoodBox.dart';
import '../components/MenuBar/menuBar.dart';
import '../components/Text/RecipeText/recipeText.dart';
import 'package:ffo/models/recipes.dart';

class RecipeDetails extends StatefulWidget {
  final RecipesModel data;
  RecipeDetails({Key key, this.title, @required this.data}) : super(key: key);
  final String title;

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
    bool recipe = true;
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
    List<String> steps_list = widget.data.steps.replaceAll('\n', '').split('. ');
     String new_text = '';
     String new_ing = '';
    for(var i = 0;i<steps_list.length;i++){
      int no = i+1;
      new_text+="\n"+no.toString()+") "+steps_list[i]+"."+"\n";
    }
    
    return Material(
        type: MaterialType.transparency,
        child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
        HeaderFoodBox(text: widget.data.name, imageUrl: widget.data.image, onBack: null),
       MenuBar(recipe: _recipe, ingredients: _ingredients,),
        recipe ? RecipeText(text: new_text)
          : RecipeText(text: widget.data.ingredients.map((item)=> item.name.toString().trim()+'\n').join(""))   
         ],),
          )
     ) );
  }
}
