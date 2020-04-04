import 'package:ffo/models/ingredients.dart';
class Recipes {
  String _id;
  String _name;
  String _steps;
  List<Ingredients> _ings;
  String _image;
 
  Recipes(this._id, this._name, this._image);
 
  Recipes.map(dynamic obj) {
    this._id = obj['name'];
    this._name = obj['name'];
    this._steps = obj['steps'];
    this._ings = obj['ingredients'];
    this._image = obj['image'];
  }
 
  String get id => _id;
  String get name => _name;
  String get image => _image;
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['name'] = _id;
    }
    map['name'] = _name;
    map['icon'] = _image;
 
    return map;
  }
 
  Recipes.fromMap(Map<String, dynamic> map) {
    this._id = map['name'];
    this._name = map['name'];
    this._image = map['icon'];
  }
}