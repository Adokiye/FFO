class Ingredients {
  String _name;
  String _image;
 
  Ingredients(this._name, this._image);
 
  Ingredients.map(dynamic obj) {
    this._name = obj['name'];
    this._image = obj['icon'];
  }
 
  String get name => _name;
  String get image => _image;
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = _name;
    map['icon'] = _image;
 
    return map;
  }
 
  Ingredients.fromMap(Map<String, dynamic> map) {
    this._name = map['name'];
    this._image = map['icon'];
  }
}