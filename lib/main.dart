import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petmate/app_theme.dart';
import 'package:petmate/views/welcoming_screen/intropage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetMate',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      themeMode: ThemeMode.system,
      home: const IntroPage(),
    );
  }
}



