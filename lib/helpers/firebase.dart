import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
 
final CollectionReference ingredientsCollection = Firestore.instance.collection('ingredients');

final CollectionReference recipesCollection = Firestore.instance.collection('recipes');
 
class FirebaseFirestoreService {
 
  static final FirebaseFirestoreService _instance = new FirebaseFirestoreService.internal();
 
  factory FirebaseFirestoreService() => _instance;
 
  FirebaseFirestoreService.internal();
 
  Stream<QuerySnapshot> getIngredientsList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = ingredientsCollection.snapshots();
 
    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
 
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
 
    return snapshots;
  }

    Stream<QuerySnapshot> getRecipesList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = recipesCollection.snapshots();
 
    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
 
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
 
    return snapshots;
  }
 
}