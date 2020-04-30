class SingleIngredient {
  final String Prediction;
 
  SingleIngredient({this.Prediction});
   factory SingleIngredient.fromJson(Map<String,dynamic> json) {
    return SingleIngredient(
      Prediction: json['Prediction']
    );
  }

}