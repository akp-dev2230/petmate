import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices{

  static getUser(){
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception('User not logged in');
    }
    return FirebaseFirestore.instance.collection("users").where('id', isEqualTo: uid).get();
  }

  static getProducts(category){
    return FirebaseFirestore.instance.collection("products").where('p_category', isEqualTo: category).snapshots();
  }

  static getWishlists(){
    return FirebaseFirestore.instance.collection("products").where('p_wishlist', arrayContains: FirebaseAuth.instance.currentUser!.uid).snapshots();
  }

  static getAddToCartItems(){
    return FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('cart').snapshots();
  }

  static getAddress(){
    return FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('address').get();
  }

  static getDoctors(specialty){
    return FirebaseFirestore.instance.collection("doctors").where('specialty', isEqualTo: specialty).snapshots();
  }


}