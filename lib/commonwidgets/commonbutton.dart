import 'package:flutter/material.dart';

Widget commonButton({width, height, onNavigate, buttonName}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.greenAccent,
      foregroundColor: Colors.black, // Text color
      shape: RoundedRectangleBorder(
        side: const BorderSide(
            color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      fixedSize: Size(width, height),
    ),
    onPressed: onNavigate,
    child: Text(
      buttonName,
      style: const TextStyle(
        color: Color(0xFF1E2433),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}