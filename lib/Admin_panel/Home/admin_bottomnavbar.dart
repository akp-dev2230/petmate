import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/Admin_panel/Admininfo/admininfo.dart';
import 'package:petmate/Admin_panel/Doctors/doctors.dart';
import 'package:petmate/Admin_panel/Home/admin_dashboard.dart';
import 'package:petmate/views/authentication_screen/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminBottomnavbar extends StatefulWidget {
  const AdminBottomnavbar({super.key});

  @override
  State<AdminBottomnavbar> createState() => _AdminBottomnavbarState();
}

class _AdminBottomnavbarState extends State<AdminBottomnavbar> {
  // List of Screens for Bottom Navigation
  final List<Widget> _pages = const [
    AdminDashboard(),
    Doctors(),
    Placeholder(),
    Admininfo()
  ];

  // Using an RxInt to track the current index
  final RxInt currentNavIndex = 0.obs;

  @override
  void initState() {
    super.initState();

    // Listen for authentication state changes
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

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => _pages.elementAt(currentNavIndex.value)),
      bottomNavigationBar: Obx(
            () => Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth*0.04, vertical: screenHeight*0.02),
          decoration: BoxDecoration(
            color: const Color(0xFF073763),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentNavIndex.value,
            onTap: (index) => currentNavIndex.value = index,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital),
                label: 'Doctors',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

