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

  calculateTotalPrice({price}){
    totalPrice.value = price * quantity.value;
  }

  resetValues(){
    totalPrice.value = 0;
    quantity.value = 0;
  }

  addToCart({title, img, sellername, color, qty, tprice}) async{
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
      Get.snackbar("","",
        titleText: const Text("Error", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
        messageText: Text("$error", style: const TextStyle(fontSize: 16, color: Colors.black),),
        backgroundColor: Colors.white,
      );
    });
  }

  addToWishlist({docId}) async{
    await FirebaseFirestore.instance.collection("products").doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    Get.snackbar("","",
      titleText: const Text("Added to wishlist", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
      backgroundColor: Colors.white,
    );
  }

  removeFromWishlist({docId}) async{
    await FirebaseFirestore.instance.collection("products").doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    Get.snackbar("","",
      titleText: const Text("Remove from wishlist", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
      backgroundColor: Colors.white,
    );
  }

}
