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


  Future<void> addToCart({productId, quantity}) async{
    try{
      final String docId = productId.id;
      final addToCartDocument = FirebaseFirestore.instance.collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid).collection('cart').doc(docId);
      final addToCartSnapshot = await addToCartDocument.get();
      int qty = 0;

      if(addToCartSnapshot.exists){
        qty = addToCartSnapshot.data()?['qty'];
      }

      if(qty + quantity <= 10){
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cart').doc(docId).set({
          'qty': FieldValue.increment(quantity),
        }, SetOptions(merge: true));
        resetValues();
        Get.snackbar("","",
          titleText: const Text("Item added to cart", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
          backgroundColor: Colors.white,
        );
      }else{
        Get.snackbar("","",
          titleText: const Text("Only 10 unit(s) of this item can be added per order", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
          backgroundColor: Colors.white,
        );
      }
    }catch(e){
      Get.snackbar("","",
        titleText: const Text("Error", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
        messageText: Text("$e", style: const TextStyle(fontSize: 16, color: Colors.black),),
        backgroundColor: Colors.white,
      );
    }
  }


}
