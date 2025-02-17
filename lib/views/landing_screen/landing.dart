import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petmate/views/Cart/cart.dart';
import 'package:petmate/views/Clinic/clinic.dart';
import 'package:petmate/views/Pharmacy/pharmacy.dart';
import 'package:petmate/views/Userinfo/accountinfo.dart';
import 'package:petmate/views/authentication_screen/loginscreen.dart';
import 'package:petmate/views/categories/category_screen.dart';
import 'package:petmate/views/landing_screen/home_screen.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _selectedIndex = 0; // Keeps track of the selected tab

  // List of Screens for Bottom Navigation
  final List<Widget> _pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const Clinic(),
    const Cart(),
    const Accountinfo(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected tab
    });
  }

  @override
  void initState() {
    super.initState();

    // Listen for authentication state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        // Navigate to login screen if user is logged out
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
      body: _pages[_selectedIndex], // Display selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.add_rounded), label: "Clinic"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }
}
