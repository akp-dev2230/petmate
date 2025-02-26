import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight*0.07,
      // The margin here creates space from the edges so it appears floating.
      margin: EdgeInsets.symmetric(horizontal: screenWidth*0.06),
      decoration: BoxDecoration(
        color: const Color(0xFF452c63), // Set your nav bar color here.
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          // Shadow to give a floating effect.
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 14,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Home Icon
          IconButton(
            onPressed: () => onTabSelected(0),
            icon: Icon(
              Icons.home,
              color: currentIndex == 0 ? const Color(0xFFc54b8c) : Colors.white70,
            ),
          ),
          // Categories Icon
          IconButton(
            onPressed: () => onTabSelected(1),
            icon: Icon(
              Icons.category,
              color: currentIndex == 1 ? const Color(0xFFc54b8c) : Colors.white70,
            ),
          ),
          // Clinic Icon
          IconButton(
            onPressed: () => onTabSelected(2),
            icon: Icon(
              Icons.add_rounded,
              color: currentIndex == 2 ? const Color(0xFFc54b8c) : Colors.white70,
            ),
          ),
          // Cart Icon
          IconButton(
            onPressed: () => onTabSelected(3),
            icon: Icon(
              Icons.shopping_cart,
              color: currentIndex == 3 ? const Color(0xFFc54b8c) : Colors.white70,
            ),
          ),
          // Account Icon
          IconButton(
            onPressed: () => onTabSelected(4),
            icon: Icon(
              Icons.person,
              color: currentIndex == 4 ? const Color(0xFFc54b8c) : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
