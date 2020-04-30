class SingleIngredient {
  final String name;
 
  SingleIngredient({this.name});
   factory SingleIngredient.fromJson(Map<String,dynamic> json) {
    return SingleIngredient(
      name: json['Prediction']
    );
  }

}