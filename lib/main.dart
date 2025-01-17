import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petmate/app_theme.dart';

void main() {
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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const IntroPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('petcare',style: Theme.of(context).textTheme.bodyLarge,),
      ),
      body:Container(

      )
    );
  }
}

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  final List<bool> _isSelected = [false, false];

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.10, vertical: screenHeight*0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.10 : screenHeight*0.25,
                      width: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth*0.22 : screenWidth*0.13,
                      decoration: BoxDecoration(
                        image: const DecorationImage(image: AssetImage('assets/images/applogo.jpg'),fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    SizedBox(width: screenWidth*0.02),
                    // App Title
                    Text(
                      'PetMate',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.yellow : Colors.blue,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight*0.02),
                // Subtitle
                Text(
                  'Your Pets need In One Place!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: screenHeight*0.02),
                // Dog Image
                Lottie.asset(
                  'assets/animation/introanimation.json',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.25 : screenHeight*0.60,
                  width: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth*0.60 : screenWidth*0.30,
                ),
                SizedBox(height: screenHeight*0.02),
                // Terms and Conditions
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'By continuing you accept our ',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      fontSize: 12.0
                    ),
                    children: [
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.yellow : Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.yellow : Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight*0.02),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('I have an Account'),
                ),
                SizedBox(height: screenHeight*0.02),
                InkWell(
                  onTap: (){

                  },
                  child: Text(
                    'Create an Account',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.yellow : Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight*0.01),
                InkWell(
                  onTap: (){

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.language,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.yellow : Colors.blue,
                        size: 16,
                      ),
                      SizedBox(width: screenWidth*0.01),
                      Text(
                        'Change Language',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.yellow : Colors.blue,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
