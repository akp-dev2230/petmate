import 'package:flutter/material.dart';

Widget commonButton({width, height, onNavigate, buttonName}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF0b5394),
      foregroundColor: Colors.black, // Text color
      shape: RoundedRectangleBorder(
        side: const BorderSide(
            color: Colors.white,
          width: 0.4
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      fixedSize: Size(width, height),
    ),
    onPressed: onNavigate,
    child: Text(
      buttonName,
      style: const TextStyle(
        color: Color(0xFFf3f6f4),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}