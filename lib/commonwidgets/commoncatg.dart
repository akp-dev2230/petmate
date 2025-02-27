import 'package:flutter/material.dart';

Widget commonCatg({width, height, onTap, required String text, required String image}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover,),
          borderRadius: BorderRadius.circular(22),
          border: Border.all( // ✅ Adds border
            //color: Colors.green, // Change color as needed
            width: 1, // Border thickness
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),),
        )
    ),
  );
}