import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:petmate/controllers/product_controller.dart';
import 'package:petmate/views/categories/cart_screen.dart';
import 'package:share_plus/share_plus.dart';

class ItemDetail extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetail({super.key, required this.title, required this.data});

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
    
    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result){
        if(didPop){
          return;
        }
        controller.resetValues();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          leading: IconButton(
            onPressed: (){
              Get.back();
              controller.resetValues();
            }, 
            icon: const Icon(Icons.arrow_back, color: Colors.black,),
          ),
          actions: [
            Obx(
            ()=> IconButton(
                onPressed: (){
                  if(controller.isFav.value){
                    controller.removeFromWishlist(data.id,context);
                  }else{
                    controller.addToWishlist(data.id,context);
                  }
                },
                icon: controller.isFav.value
                    ? const Icon(Icons.favorite_outlined, color: Colors.redAccent,)
                    : const Icon(Icons.favorite_outline, color: Colors.black,),
              ),
            ),
            IconButton(
              onPressed: (){
                Share.share("Check out this amazing");
              },
              icon: const Icon(Icons.share, color: Colors.black,),
            ),
          ],
          title: Text(title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(data['p_image'],width: double.infinity,fit: BoxFit.cover,),
                  SizedBox(height: screenHeight*0.02,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth*0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).appBarTheme.foregroundColor,
                          ),
                        ),
                        Text("${data['p_desc']}", style: Theme.of(context).textTheme.bodyMedium,),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: double.parse(data['p_rating']),
                              itemBuilder: (context, index){
                                return const Icon(Icons.star, color: CupertinoColors.systemGreen,);
                              },
                              itemCount: 5,
                              itemSize: 20,
                            ),
                            Text("(${data['p_rating']} rating)", style: Theme.of(context).textTheme.bodyMedium,)
                          ],
                        ),
                        SizedBox(height: screenHeight*0.02,),
                        Text(
                          "₹${data['p_price']}.00",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).appBarTheme.foregroundColor,
                          ),
                        ),
                        Text("Seller: ${data['p_seller']}", style: Theme.of(context).textTheme.bodyMedium,),
                        SizedBox(height: screenHeight*0.01,),
                        Divider(color: Theme.of(context).appBarTheme.foregroundColor,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Quantity",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).appBarTheme.foregroundColor,
                              ),
                            ),
                            Obx(() => Row(
                              children: [
                                IconButton(onPressed: (){
                                  controller.decreaseQuantity();
                                  controller.calculateTotalPrice(int.parse(data['p_price']));
                                }, icon: const Icon(Icons.remove)),
                                Text(
                                  "${controller.quantity.value}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).appBarTheme.foregroundColor,
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  controller.increaseQuantity(int.parse(data['p_quantity']));
                                  controller.calculateTotalPrice(int.parse(data['p_price']));
                                }, icon: const Icon(Icons.add)),
                                Text("${data['p_quantity']} available", style: Theme.of(context).textTheme.bodyMedium,),
                              ],
                            ),
                            ),
                          ],
                        ),
                        Divider(color: Theme.of(context).appBarTheme.foregroundColor,),
                        Text(
                          "Delivery & Services",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).appBarTheme.foregroundColor,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.local_shipping),
                          title: Text("Get it by $formattedDate"),
                        ),
                        const ListTile(
                          leading: Icon(Icons.repeat),
                          title: Text("7 days Return & Exchange"),
                        ),
                        SizedBox(height: screenHeight*0.07,)
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
                          child: Center(child: Text("₹${controller.totalPrice.value}.00", style: const TextStyle(color: Colors.black),)),
                        ),
                      ),
                      // Divider(color: Colors.black,),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            if(controller.quantity.value>=1){
                              Get.to(const CartScreen());
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                backgroundColor: Colors.white,
                                content: Text("Oops cart is empty!", textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
                              ));
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.greenAccent,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Add to Cart ", style: TextStyle(color: Colors.black)),
                                  Icon(CupertinoIcons.cart_fill, color: Colors.black,)
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
