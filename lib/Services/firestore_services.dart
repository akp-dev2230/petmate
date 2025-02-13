import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices{

  static getProducts(category){
    return FirebaseFirestore.instance.collection("products").where('p_category', isEqualTo: category).snapshots();
  }

}