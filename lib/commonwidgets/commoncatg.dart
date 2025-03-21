import 'package:flutter/material.dart';

Widget commonCatg({width, height, onTap, required String text, required String image}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:Column(
            children: [
              Text(text,
                style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  height: height * 1,
                  width: width * 3,
                ),
              ),
            ],
          )
        )
    ),
  );
}