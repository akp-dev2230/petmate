import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{

  var quantity = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;

  increaseQuantity(totalQuantity){
    if(quantity.value < totalQuantity){
      quantity.value++;
    }
  }

  decreaseQuantity(){
    if(quantity.value > 0){
      quantity.value--;
    }
  }

  calculateTotalPrice(price){
    totalPrice.value = price * quantity.value;
  }

  resetValues(){
    totalPrice.value = 0;
    quantity.value = 0;
  }

  addToCart({title, img, sellername, color, qty, tprice, context}) async{
    await FirebaseFirestore.instance.collection("cartCollection").doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      // 'vendor_id': vendorID,
      'tprice': tprice,
      'added_by': FirebaseAuth.instance.currentUser!.uid,
    }).catchError((error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text("Error: $error", style: const TextStyle(fontSize: 16),),
      ));
    });
  }

  addToWishlist(docId,context) async{
    await FirebaseFirestore.instance.collection("products").doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.white,
      content: Text("Added to wishlist", style: TextStyle(fontSize: 16),),
    ));
  }

  removeFromWishlist(docId,context) async{
    await FirebaseFirestore.instance.collection("products").doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.white,
      content: Text("Remove from wishlist", style: TextStyle(fontSize: 16),),
    ));
  }

}
