import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/Services/firestore_services.dart';
import 'package:petmate/views/categories/item_detail.dart';

class CategoryItem extends StatelessWidget {
  final String? title;
  const CategoryItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("$title", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
              ),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return Center(
              child: Text("No products found",style: Theme.of(context).textTheme.bodyLarge,),
            );
          }else{
            var data = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                physics:const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,mainAxisExtent: 250,mainAxisSpacing: 8,crossAxisSpacing: 8),
                itemBuilder: (context,index) {
                  return InkWell(
                    onTap: (){
                      Get.to(()=>ItemDetail(title: "${data[index]['p_name']}", data: data[index],));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.3), // Shadow color with opacity
                          spreadRadius: 2,  // How much the shadow spreads
                          blurRadius: 5,     // How soft the shadow appears
                          offset: const Offset(3, 3), // Changes position of shadow (x, y)
                        )],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(data[index]['p_image'],width: 200,height: 150,fit: BoxFit.cover,),
                          const Divider(),
                          Text(
                            data[index]['p_name'].length > 15
                                ? "${data[index]['p_name'].substring(0,15)}..."
                                : "${data[index]['p_name']}",
                            style: const TextStyle(color: Colors.black, fontSize: 16,),
                          ),
                          const SizedBox(height: 10,),
                          Text("₹${data[index]['p_price']}.00", style: const TextStyle(color: Colors.black, fontSize: 16,)),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }

        },
      ),
    );
  }
}
