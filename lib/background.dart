import 'package:flutter/material.dart';

Widget backGround({required Widget child}){
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter, // Starting point of the gradient
        end: Alignment.bottomCenter, // Ending point of the gradient
        colors: [
          // Color(0xFF6f4685),  // First gradient color
          Color(0xFF6fa8dc),
          Colors.white// Second gradient color
        ],
      ),
    ),
    child: child,
  );
}