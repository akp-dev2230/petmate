import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/controllers/product_controller.dart';

class ItemDetail extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetail({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    
    var controller = Get.put(ProductController());
    
    return PopScope(
      canPop: false,
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
          title: Text(title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
        ),
        body: Container(),
      ),
    );
  }
}
