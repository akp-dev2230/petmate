import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/app_theme.dart';
import 'package:petmate/views/landing_screen/landing.dart';
import 'package:petmate/views/welcoming_screen/intropage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Check if a user is already logged in
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(isLoggedIn: user != null, userId: user?.uid));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? userId;
  const MyApp({super.key, required this.isLoggedIn, this.userId});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PetMate',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      themeMode: ThemeMode.system,
      home: isLoggedIn ? const Landing() : const IntroPage(),
    );
  }
}



