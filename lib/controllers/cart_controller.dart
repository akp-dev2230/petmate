import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController{

  void removeToCart({productDoc}) async{
    try{
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart').doc(productDoc).delete().then((value){
        Get.snackbar("","",
          titleText: const Text("Item removed from bag", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
          backgroundColor: Colors.white,
        );
      });
    }catch(e){
      Get.snackbar("","",
        titleText: const Text("Error", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
        messageText: Text("$e", style: const TextStyle(fontSize: 16, color: Colors.black),),
        backgroundColor: Colors.white,
      );
    }
  }



  Future<void> showQuantityBottomSheet({required BuildContext context,
    required String productDoc, required int currentQuantity}) async {
    // The selected quantity inside the bottom sheet
    int tempSelectedQty = currentQuantity;

    final newQuantity = await showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            return Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Select Quantity', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(10, (index) {
                          final qtyValue = index + 1;
                          final isSelected = qtyValue == tempSelectedQty;
                          return GestureDetector(
                            onTap: () {
                              setStateSB(() {
                                tempSelectedQty = qtyValue;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: isSelected ? const Color(0xFFec2020)
                                    : (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
                              ),
                              child: Text('$qtyValue', style: TextStyle(color: isSelected ? const Color(0xFFec2020)
                                  : (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                                fontWeight: FontWeight.bold,),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(tempSelectedQty);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0b5394),
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: const Text('DONE', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (newQuantity != null && newQuantity != currentQuantity) {
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("cart").doc(productDoc).update({"qty": newQuantity});
    }
  }


}