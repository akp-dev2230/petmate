import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/Services/firestore_services.dart';
import 'package:petmate/background.dart';
import 'package:petmate/controllers/product_controller.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Wishlist", style: Theme.of(context).appBarTheme.titleTextStyle,),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
        ),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getWishlists(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color(0xFF073763)),),
              );
            }else if(snapshot.data!.docs.isEmpty){
              return backGround(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/wishlist.png",
                      height: screenHeight*0.25, // Adjust height as needed
                      width: screenWidth*0.5,  // Adjust width as needed
                      fit: BoxFit.cover, // Adjust the fit if needed
                    ),
                    Text(
                      "Wishlist",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                )

              );
            }else{
              var data = snapshot.data!.docs;
              return backGround(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index){
                          return FadeInUp(
                            delay: Duration(milliseconds: 10*index),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.02, vertical: screenHeight*0.005),
                              child: Card(
                                elevation: 2.0,
                                shadowColor: Colors.grey,
                                child: ListTile(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  tileColor: Colors.white,
                                  leading: Image.network("${data[index]['p_image']}",width: 80, fit: BoxFit.cover,),
                                  title: Text(data[index]['p_name'].length > 15
                                      ? "${data[index]['p_name'].substring(0,15)}..."
                                      : "${data[index]['p_name']}",
                                    style: const TextStyle(fontSize: 16, color: Colors.black),
                                  ),
                                  subtitle: Text("₹${data[index]['p_price']}.00", style: TextStyle(fontSize: 18, color: Colors.green.shade800),),
                                  trailing: IconButton(
                                    onPressed: (){
                                      controller.removeFromWishlist(docId: data[index].id);
                                    },
                                    icon: const Icon(Icons.favorite, size: 30, color: Color(0xFFff1a1a),),
                                  )
                                ),
                              ),
                            ),
                          );
                        },
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
