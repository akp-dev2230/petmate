import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices{

  static getProducts(category){
    return FirebaseFirestore.instance.collection("products").where('p_category', isEqualTo: category).snapshots();
  }

  static getWishlists(){
    return FirebaseFirestore.instance.collection("products").where('p_wishlist', arrayContains: FirebaseAuth.instance.currentUser!.uid).snapshots();
  }

}