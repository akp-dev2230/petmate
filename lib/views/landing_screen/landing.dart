import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/views/Cart/cart.dart';
import 'package:petmate/views/Clinic/clinic.dart';
import 'package:petmate/views/Userinfo/accountinfo.dart';
import 'package:petmate/views/authentication_screen/loginscreen.dart';
import 'package:petmate/views/categories/category_screen.dart';
import 'package:petmate/views/landing_screen/bottomnavbar.dart';
import 'package:petmate/views/landing_screen/home_screen.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  // List of Screens for Bottom Navigation
  final List<Widget> _pages = const [
    HomeScreen(),
    CategoryScreen(),
    Clinic(),
    Cart(),
    Accountinfo(),
  ];

  // Using an RxInt to track the current index.
  final RxInt currentNavIndex = 0.obs;

  @override
  void initState() {
    super.initState();

    // Listen for authentication state changes.
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set a background color (or image) so the floating effect is visible.
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          // Main content.
          Obx(() => _pages.elementAt(currentNavIndex.value)),

          // Floating nav bar positioned at the bottom.
          Positioned(
            bottom: 18,
            left: 0,
            right: 0,
            child: Obx(
                  () => CustomBottomNavBar(
                currentIndex: currentNavIndex.value,
                onTabSelected: (index) => currentNavIndex.value = index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
