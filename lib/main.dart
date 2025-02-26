import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/app_theme.dart';
import 'package:petmate/views/landing_screen/landing.dart';
import 'package:petmate/views/welcoming_screen/intropage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(
    url: 'https://ragaowmdqvtrppxyjwjo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJhZ2Fvd21kcXZ0cnBweHlqd2pvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk4MDQ1NTEsImV4cCI6MjA1NTM4MDU1MX0.UYjjK56T5uxb5IfJmHF_zBRXNxKHWPbeaVzeQzVbCfI',
  );

  // Check if a user is already logged in
  firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;
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
      theme: AppTheme.appTheme(context),
      themeMode: ThemeMode.system,
      home: isLoggedIn ? const Landing() : const IntroPage(),
    );
  }
}



