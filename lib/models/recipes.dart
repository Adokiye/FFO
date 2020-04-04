import 'package:ffo/models/ingredients.dart';
class Recipes {
  String _name;
  String _steps;
  List<Ingredients> _ings;
  String _image;
 
  Recipes(this._name, this._image, this._steps, this._ings);
 
  Recipes.map(dynamic obj) {
    this._name = obj['name'];
    this._steps = obj['steps'];
    this._ings = obj['ingredients'];
    this._image = obj['image'];
  }
 
  String get name => _name;
  String get image => _image;
  String get steps => _steps;
  List get ingredients => _ings;
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = _name;
    map['image'] = _image;
    map['steps'] = _steps;
    map['ingredients'] = _ings.map((attribute) {
  Map<String,dynamic> attributeMap = new Map<String,dynamic>();
  attributeMap["name"] = attribute.name;
  attributeMap["icon"] = attribute.image;
  // same for xpos and ypos
  return attributeMap;
}).toList();
    return map;
  }
 
  Recipes.fromMap(Map<String, dynamic> map) {
    this._name = map['name'];
    this._image = map['image'];
    this._ings = map['ingredients'];
    this._steps = map['steps'];
  }
}