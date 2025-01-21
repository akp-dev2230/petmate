import 'package:flutter/material.dart';

Widget commonTextfield({hinttext, obstxt, height, width, controller }){
  return Container(
    width: width ,
    height: height,
    child: TextField(
      controller: controller,
      obscureText: obstxt,
      decoration: InputDecoration(
          hintText: hinttext,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
          )
      ),
    ),
  );
}