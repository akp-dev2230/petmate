import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight*0.07,
      // The margin here creates space from the edges so it appears floating.
      margin: EdgeInsets.symmetric(horizontal: screenWidth*0.06),
      decoration: BoxDecoration(
        color: const Color(0xFF073763), // Set your nav bar color here.
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
              size: currentIndex == 0 ? 30 : 22,
              color: Colors.white,
            ),
          ),
          // Categories Icon
          IconButton(
            onPressed: () => onTabSelected(1),
            icon: Icon(
              Icons.category,
              size: currentIndex == 1 ? 30 : 22,
              color: Colors.white,
            ),
          ),
          // Clinic Icon
          IconButton(
            onPressed: () => onTabSelected(2),
            icon: Icon(
              Icons.add_rounded,
              size: currentIndex == 2 ? 30 : 22,
              color: Colors.white,
            ),
          ),
          // Cart Icon
          IconButton(
            onPressed: () => onTabSelected(3),
            icon: Icon(
              Icons.shopping_cart,
              size: currentIndex == 3 ? 30 : 22,
              color: Colors.white,
            ),
          ),
          // Account Icon
          IconButton(
            onPressed: () => onTabSelected(4),
            icon: Icon(
              Icons.person,
              size: currentIndex == 4 ? 30 : 22,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
