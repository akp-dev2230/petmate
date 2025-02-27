import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:petmate/background.dart';
import 'package:petmate/controllers/product_controller.dart';
import 'package:share_plus/share_plus.dart';

class ItemDetail extends StatelessWidget {
  final dynamic productId;
  const ItemDetail({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());

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

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    dynamic wishlistRaw = productId['p_wishlist'];
    wishlistRaw = wishlistRaw.where((item) {
      return item is String && item.isNotEmpty;
    }).toList();

    controller.isFav.value = wishlistRaw.contains(FirebaseAuth.instance.currentUser!.uid);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: (){
            Get.back();
            controller.resetValues();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
        ),
        actions: [
          Obx(
                ()=> IconButton(
              onPressed: (){
                if(controller.isFav.value){
                  controller.removeFromWishlist(docId: productId.id);
                }else{
                  controller.addToWishlist(docId: productId.id);
                }
              },
              icon: controller.isFav.value
                  ? const Icon(Icons.favorite_outlined, color: Color(0xFFff1a1a),)
                  : const Icon(Icons.favorite_outline, color: Colors.white,),
            ),
          ),
          IconButton(
            onPressed: (){
              Share.share("Check out this amazing");
            },
            icon: const Icon(Icons.share, color: Colors.white,),
          ),
        ],
        title: Text(productId['p_name']),
      ),
      body: backGround(
        child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0), // Adjust the radius as needed
                        child: Image.network(
                          productId['p_image'],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight*0.02,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth*0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productId['p_name'], style: Theme.of(context).textTheme.titleMedium
                          ),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: double.parse(productId['p_rating'].toString()),
                                itemBuilder: (context, index){
                                  return const Icon(Icons.star, color: Colors.orangeAccent,);
                                },
                                itemCount: 5,
                                itemSize: 20,
                              ),
                              Text("(${productId['p_rating']} rating)", style: Theme.of(context).textTheme.titleMedium)
                            ],
                          ),
                          SizedBox(height: screenHeight*0.02,),
                          Text(
                            "₹${productId['p_price'].toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green.shade800)
                          ),
                          SizedBox(height: screenHeight*0.01,),
                          const Divider(color: Colors.black,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Quantity",
                                  style: Theme.of(context).textTheme.titleMedium
                              ),
                              Obx(() => Row(
                                children: [
                                  IconButton(onPressed: (){
                                    controller.decreaseQuantity();
                                    controller.calculateTotalPrice(price: productId['p_price']);
                                  }, icon: const Icon(Icons.remove)),
                                  Text(
                                    "${controller.quantity.value}",
                                      style: TextStyle(fontSize: 18, color: controller.quantity.value > 0 ? const Color(0xFFec2020) : Colors.black)
                                  ),
                                  IconButton(onPressed: (){
                                    controller.increaseQuantity(productId['p_quantity']);
                                    controller.calculateTotalPrice(price: productId['p_price']);
                                  }, icon: const Icon(Icons.add)),
                                  Text("${productId['p_quantity']} available", style: Theme.of(context).textTheme.bodyMedium,),
                                ],
                              ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.black,),
                          Text(
                            "Delivery & Services",
                              style: Theme.of(context).textTheme.titleMedium
                          ),
                          ListTile(
                            leading: const Icon(Icons.local_shipping),
                            title: Row(
                              children: [
                                Text("Get it by ", style: Theme.of(context).textTheme.bodyMedium,),
                                Text(formattedDate, style: Theme.of(context).textTheme.titleMedium,),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.repeat),
                            title: Row(
                              children: [
                                Text("7 days ", style: Theme.of(context).textTheme.titleMedium,),
                                Text("Return & Exchange", style: Theme.of(context).textTheme.bodyMedium,),
                              ],
                            ),
                          ),
                          const Divider(color: Colors.black,),
                          Row(
                            children: [
                              Text("Seller: ", style: Theme.of(context).textTheme.titleMedium,),
                              Text(productId['p_seller'], style: Theme.of(context).textTheme.bodyMedium,),
                            ],
                          ),
                          Text("${productId['p_desc']}", style: Theme.of(context).textTheme.bodySmall,),

                          SizedBox(height: screenHeight*0.07,),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  height: screenHeight*0.07,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  child: Obx(
                        ()=> Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: CupertinoColors.systemGrey6,
                            child: Center(child: Text("₹${(controller.totalPrice.value).toStringAsFixed(2)}", 
                              style: TextStyle(color: controller.totalPrice.value > 0 ? Colors.green.shade800 : Colors.black),)),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async{
                              if(controller.quantity.value>=1){
                                await controller.addToCart(
                                  productId: productId,
                                  quantity: controller.quantity.value,
                                ).then((value){
        
                                });
                              }else{
                                Get.snackbar("","",
                                  titleText: const Text("Please select quantity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
                                  backgroundColor: Colors.white,
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: const Color(0xFF0b5394),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Add to Cart ", style: TextStyle(color: Color(0xFFf3f6f4))),
                                  Icon(CupertinoIcons.cart_fill, color: Color(0xFFf3f6f4),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}
