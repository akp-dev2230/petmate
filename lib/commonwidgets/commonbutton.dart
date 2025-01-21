import 'package:flutter/material.dart';

Widget commonButton({onNavigate,buttonName, width, height, clr, txtclr}){
  return ElevatedButton(
    onPressed: onNavigate,
    child: Text(buttonName, style: TextStyle(fontSize: 17, color: txtclr)),
    style: ElevatedButton.styleFrom(
      backgroundColor: clr,
      foregroundColor: Colors.white70, // Text color
      shape: RoundedRectangleBorder(
        side: const BorderSide(
            color: Colors.white
        ),
        borderRadius: BorderRadius.circular(35),
      ),
      fixedSize: Size(width, height),
    ),
  );
}