import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/app_theme.dart';
import 'package:petmate/views/landing_screen/bottomnavbar.dart';
import 'package:petmate/views/welcoming_screen/display.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Admin_panel/Home/admin_bottomnavbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Supabase.initialize(
    url: 'https://ragaowmdqvtrppxyjwjo.supabase.co',
    anonKey: 'your-anon-key',
  );

  runApp(const StartupApp());
}

class StartupApp extends StatelessWidget {
  const StartupApp({super.key});

  Future<Widget> _getInitialScreen() async {
    firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Display();
    }

    final uid = user.uid;
    final firestore = FirebaseFirestore.instance;

    try {
      // Check if the user is an admin
      final adminSnapshot = await firestore.collection('admin').doc(uid).get();
      if (adminSnapshot.exists) {
        return const AdminBottomnavbar();
      }

      // If not an admin, check if it's a normal user
      final userSnapshot = await firestore.collection('users').doc(uid).get();
      if (userSnapshot.exists) {
        return const CustomBottomNavBar();
      }

      // Not found in either collection, go to intro page
      return const Display();
    } catch (e) {
      // On error, return intro or handle gracefully
      return const Display();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getInitialScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return MyApp(home: snapshot.data!);
      },
    );
  }
}

class MyApp extends StatelessWidget {
  final Widget home;
  const MyApp({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PetMate',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme(context),
      themeMode: ThemeMode.system,
      home: home,
    );
  }
}
