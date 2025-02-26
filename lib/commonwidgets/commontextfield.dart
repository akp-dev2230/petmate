import 'package:flutter/material.dart';

Widget commonTextfield({controller, obstxt, preFixIcon, hinttext, suFFixIcon, suffIconPressed, required BuildContext context}){
  return TextField(
    controller: controller,
    obscureText: obstxt ?? false,
    cursorColor: Colors.black,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
    decoration: InputDecoration(
      prefixIcon: Icon(preFixIcon, color: Colors.black,),
      hintText: hinttext,
      hintStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
      suffixIcon: IconButton(onPressed: suffIconPressed, icon: Icon(suFFixIcon,color: Colors.black,)),
      enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 0.4,
            )
        ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          )
      ),
    ),
  );
}