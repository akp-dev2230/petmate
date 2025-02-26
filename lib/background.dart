import 'package:flutter/material.dart';

Widget backGround({required Widget child}){
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft, // Starting point of the gradient
        end: Alignment.bottomRight, // Ending point of the gradient
        colors: [
          Color(0xFFD8BFD8),  // First gradient color
          Color(0xFF6f4685),  // Second gradient color
        ],
      ),
    ),
    child: child,
  );
}