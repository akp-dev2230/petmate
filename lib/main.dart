import 'package:flutter/material.dart';
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

  List<bool> _isSelected = [false, false];

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
                      width: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth*0.22 : screenWidth*0.20,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.pets,
                        color: Colors.black,
                        size: 60,
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
                const SizedBox(height: 8),
                // Subtitle
                Text(
                  'Your Pets need In One Place!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                // Dog Image
                Image.asset(
                  'assets/dog.png', // Replace with your asset path
                  height: 150,
                ),
                const SizedBox(height: 16),
                // Theme Toggle
                Text(
                  'Change Colour Theme:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wb_sunny, color: Colors.yellow),
                    SizedBox(width: 8),
                    ToggleButtons(
                      selectedColor: Colors.white,
                      fillColor: Colors.red,
                      isSelected: _isSelected,
                      onPressed: (int index){
                        setState(() {
                          for(int i = 0; i<_isSelected.length; i++){
                            _isSelected[i] = i == index;
                          }
                        });
                      },
                      children: [
                        Icon(Icons.toggle_on, color: Colors.yellow, size: 36),
                        Icon(Icons.nightlight, color: Colors.white),
                      ],
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.nightlight, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
                // Buttons
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('I have an Account'),
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 8),
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
                      const SizedBox(width: 4),
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
