import 'package:flutter/material.dart';

Widget commonCatg({width, height, onTap, required String text, required ImageProvider image, horizontal, vertical}){
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal:horizontal,
      vertical:vertical
  ),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(image: image, fit: BoxFit.cover,),
            borderRadius: BorderRadius.circular(22),
            border: Border.all( // ✅ Adds border
              color: Colors.green, // Change color as needed
              width: 1, // Border thickness
            ),
          ),
          child: Text(text,style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),)
      ),
    ),
  );
}