import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petmate/views/welcoming_screen/display.dart';


class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth*0.10 : screenWidth*0.15,
              vertical: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.05 : screenHeight*0.10,
            ),
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
                        image: const DecorationImage(image: AssetImage('assets/images/PETMATE3.jpg'),fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    SizedBox(width: screenWidth*0.02),
                    // App Title
                    Text(
                      'PetMate',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent : Colors.blue,
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
                // welcoming theme
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
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Display()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.02 : screenHeight*0.05,
                      horizontal: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth*0.25 : screenWidth*0.20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Color(0xFF1E2433),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight*0.02),

              ],
            ),
          ),
        ),
      ),
    );
  }
}