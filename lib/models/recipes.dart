import 'package:ffo/models/ingredients.dart';
class RecipesModel {
  String _name;
  String _steps;
  Ingredients _ings;
  String _image;
 
  RecipesModel(this._name, this._image, this._steps, this._ings);
 
  RecipesModel.map(dynamic obj) {
    this._name = obj['name'];
    this._steps = obj['steps'];
    this._ings = obj['ingredients'];
    this._image = obj['image'];
  }
 
  String get name => _name;
  String get image => _image;
  String get steps => _steps;
  Ingredients get ingredients => _ings;
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = _name;
    map['image'] = _image;
    map['steps'] = _steps;
    map['ingredients'] = _ings.toMap();
    return map;
  }
 
  RecipesModel.fromMap(Map<String, dynamic> map) {
    this._name = map['name'];
    this._image = map['image'];
    this._ings = map['ingredients'];
    this._steps = map['steps'];
  }
}