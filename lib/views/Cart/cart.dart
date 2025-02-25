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

    String getWeekday(int weekday) {
      const weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
      return weekdays[weekday - 1];
    }
    String getMonth(int month) {
      const months = [
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
      ];
      return months[month - 1];
    }
    DateTime date = DateTime.now().add(const Duration(days: 2));
    String formattedDate = "${getWeekday(date.weekday)}, ${date.day} ${getMonth(date.month)}";

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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth*0.03, vertical: screenHeight*0.015),
                    child: Column(
                      children: [
                        //item section
                        ListView.builder(
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
                                  return Container();
                                }

                                final productData = productSnapshot.data!.data() as Map<String, dynamic>;
                                final productPrice = productData['p_price'];
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  totalMRP.value += ((productPrice) * quantity) as int;
                                });

                                return Column(
                                  children: [
                                    Card(
                                      elevation: 1.0,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: screenWidth*0.02, vertical: screenHeight*0.02),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Image.network(productData['p_image'], height: screenHeight*0.15, width: screenWidth*0.25, fit: BoxFit.contain),
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
                                                          Text("MRP - ${productPrice.toStringAsFixed(2)}", style: const TextStyle(fontSize: 16, color: Colors.black87)),
                                                          GestureDetector(
                                                            onTap: (){
                                                              cartController.showQuantityBottomSheet(
                                                                context: context,
                                                                productDoc: productDoc,
                                                                currentQuantity: quantity,
                                                              );
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Text("Qty - $quantity", style: const TextStyle(fontSize: 16, color: Colors.black87)),
                                                                const Icon(Icons.arrow_drop_down, color: Colors.black87,)
                                                              ],
                                                            ),
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
                                                InkWell(
                                                  onTap: (){
                                                    cartController.removeToCart(productDoc: productDoc);
                                                  },
                                                  child: const Icon(Icons.delete_outline, color: Colors.redAccent,),
                                                ),

                                              ],
                                            ),
                                            const Divider(),
                                            Row(
                                              children: [
                                                const Icon(Icons.local_shipping_outlined, color: Color(0xFF1E2433)),
                                                const Text(" Delivery by ", style: TextStyle(fontSize: 16, color: Colors.black)),
                                                Text(formattedDate, style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight*0.01,),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: screenHeight*0.02,),

                        //billing section
                        Obx( () {
                          discount.value = (totalMRP.value * 0.1).toInt();
                          totalAmount.value = (totalMRP.value - discount.value + 99).toInt();
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.03, vertical: screenHeight*0.015),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 1)],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Price Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
                                const Divider(),
                                _priceDetailRow(title: "Total MRP", value: "₹${(totalMRP.value).toDouble().toStringAsFixed(2)}"),
                                _priceDetailRow(
                                  title: "Discount on MRP",
                                  value: "- ₹${(discount.value).toDouble().toStringAsFixed(2)}",
                                  color: Colors.green,
                                ),
                                _priceDetailRow(title: "Coupon Discount", value: "- ₹0.00"),
                                _priceDetailRow(title: "Delivery Fee", value: "₹99.00", color: Colors.green),
                                const Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Total Amount",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)
                                    ),
                                    Text(
                                      (totalAmount.value).toDouble().toStringAsFixed(2),
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                        SizedBox(height: screenHeight*0.02,),

                        //proceed to buy button
                        SizedBox(
                          width: double.infinity,
                          height: screenHeight*0.06,
                          child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.greenAccent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                            ),
                            child: const Text("Proceed to Buy", style: TextStyle(fontSize: 18, color: Colors.black),),
                          ),
                        ),
                      ],
                    ),
                  ),

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
        Text(title, style: const TextStyle(fontSize: 16, color: Colors.black)),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: color)),
      ],
    ),
  );
}

