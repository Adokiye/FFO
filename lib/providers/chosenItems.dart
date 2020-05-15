import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:ffo/models/ingredients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffo/helpers/firebase.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';

class ChosenItemsModel extends ChangeNotifier {
  ChosenItemsModel(){
   ingredientsSub?.cancel();
    ingredientsSub = db.getIngredientsList().listen((QuerySnapshot snapshot) {
      final List<Ingredients> ings = snapshot.documents
          .map((documentSnapshot) => Ingredients.fromMap(documentSnapshot.data))
          .toList();
            _items = ings;
    }, );
  }
   FirebaseFirestoreService db = new FirebaseFirestoreService();
  StreamSubscription<QuerySnapshot> ingredientsSub;
  /// Internal, private state of the cart.
  List<Ingredients> _items = [];
  final List<Ingredients> _chosenItems = [];
   List<String> _chosenNames = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Ingredients> get items => UnmodifiableListView(_items);

  UnmodifiableListView<Ingredients> get chosenItems => UnmodifiableListView(_chosenItems);

    UnmodifiableListView<String> get chosenNames => UnmodifiableListView(_chosenNames);
  
  void initialItems(List<Ingredients> initials){
    _items = initials;
  }

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Ingredients item) {
    var check = _chosenItems.where((item) => item.name == item.name).toList();
    _chosenItems.add(item);
    _items.remove(item);
    if (check.isEmpty) {
      _chosenItems.add(item);
      _chosenNames.add(item.name);
      _items.removeWhere((itemM) => itemM.name == item.name);
    }
    notifyListeners();
  }

  void removeItem(index) {
    if (_chosenItems.isNotEmpty) {
      _items.add(_chosenItems[index]);
    }
    _chosenItems.removeAt(index);
    _chosenNames.removeAt(index);
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
