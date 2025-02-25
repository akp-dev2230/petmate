import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/Services/firestore_services.dart';
import 'package:petmate/controllers/cart_controller.dart';
import 'package:petmate/views/Cart/editaddress.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {

    var cartController = Get.put(CartController());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final totalMRP = 0.obs;
    final discount = 0.obs;
    final totalAmount = 0.obs;

    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.greenAccent,
        title: const Text("Shopping Bag", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAddToCartItems(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.greenAccent),),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return Center(
              child: Text("No products found",style: Theme.of(context).textTheme.bodyLarge,),
            );
          }else{
            var data = snapshot.data!.docs;

            return SingleChildScrollView(
              child: Column(
                children: [
                  //address section
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth*0.03, vertical: screenHeight*0.015),
                    decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20),),
                        border: Border(bottom: BorderSide(color: Colors.orange.shade200, width: 2.0,),)
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.orange),
                        const Text(" Delivering to ", style: TextStyle(color: Colors.black),),
                        const Text("140603", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        const Spacer(),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Editaddress()));
                          },
                          child: const Icon(Icons.edit, color: Colors.orange),
                        ),
                      ],
                    ),
                  ),

                  //item section
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {

                        final productDoc = data[index].id;
                        final quantity = data[index]['qty'];

                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance.collection('products').doc(productDoc).get(),
                          builder: (context, productSnapshot){
                            if(!productSnapshot.hasData){
                              return const Center(
                                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.greenAccent),),
                              );
                            }

                            final productData = productSnapshot.data!.data() as Map<String, dynamic>;
                            final productPrice = productData['p_price'];
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              totalMRP.value += ((productPrice) * quantity) as int;
                            });

                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: screenWidth*0.04, vertical: screenHeight*0.01),
                              decoration: BoxDecoration(
                                color: CupertinoColors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth*0.025, vertical: screenHeight*0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(productData['p_image'], height: 120, width: 100, fit: BoxFit.contain),
                                        SizedBox(width: screenWidth*0.02),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(productData['p_name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)),
                                              SizedBox(height: screenHeight*0.005),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("MRP - ${productPrice.toStringAsFixed(2)}", style: const TextStyle(color: Colors.black87)),
                                                  GestureDetector(
                                                    onTap: (){
                                                      cartController.showQuantityBottomSheet(
                                                        context: context,
                                                        productDoc: productDoc,
                                                        currentQuantity: quantity,
                                                      );
                                                    },
                                                    child: Text("qty - $quantity", style: const TextStyle(color: Colors.black54)),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "₹${(productPrice * quantity).toStringAsFixed(2)}",
                                                style: const TextStyle(fontSize: 18, color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: (){
                                            cartController.removeToCart(productDoc: productDoc);
                                          },
                                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent,),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    const Row(
                                      children: [
                                        Icon(Icons.local_shipping_outlined, color: Color(0xFF1E2433)),
                                        Text(" Delivery by", style: TextStyle(color: Colors.black)),
                                        Text(" Mon, 24th Feb", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  //billing section
                  Obx( () {
                    discount.value = (totalMRP.value * 0.1).toInt();
                    totalAmount.value = (totalMRP.value - discount.value + 99).toInt();
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: screenWidth*0.035, vertical: screenHeight*0.02),
                      padding: EdgeInsets.symmetric(horizontal: screenWidth*0.03, vertical: screenHeight*0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 1)],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Price Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                          const Divider(),
                          _priceDetailRow(title: "Total MRP", value: "₹${(totalMRP.value).toDouble().toStringAsFixed(2)}"),
                          _priceDetailRow(
                            title: "Discount on MRP",
                            value: "- ₹${(discount.value).toDouble().toStringAsFixed(2)}",
                            color: Colors.green,
                          ),
                          _priceDetailRow(title: "Coupon Discount", value: "- ₹0.00"),
                          _priceDetailRow(title: "Delivery Fee", value: "₹99.00 FREE", color: Colors.green),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total Amount",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)
                              ),
                              Text(
                                (totalAmount.value).toDouble().toStringAsFixed(2),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),

                ],
              ),
            );
          }
        },
      ),
    );
  }
}


Widget _priceDetailRow({required String title, required String value, Color color = Colors.black, bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, color: Colors.black)),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: color)),
      ],
    ),
  );
}

