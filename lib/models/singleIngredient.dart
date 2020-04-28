class SingleIngredient {
  final String name;
  final String image;
 
  SingleIngredient({this.name, this.image});
   factory SingleIngredient.fromJson(Map<String,dynamic> json) {
    return SingleIngredient(
      name: json['name'],
      image: json['image']
    );
  }

}