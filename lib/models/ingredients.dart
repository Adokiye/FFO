class Ingredients {
  String _id;
  String _name;
  String _image;
 
  Ingredients(this._id, this._name, this._image);
 
  Ingredients.map(dynamic obj) {
    this._id = obj['name'];
    this._name = obj['name'];
    this._image = obj['icon'];
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
 
  Ingredients.fromMap(Map<String, dynamic> map) {
    this._id = map['name'];
    this._name = map['name'];
    this._image = map['icon'];
  }
}