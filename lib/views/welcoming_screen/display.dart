import 'package:flutter/material.dart';
import 'package:petmate/views/authentication_screen/loginscreen.dart';
import 'package:petmate/views/authentication_screen/signupscreen.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<Display> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Map<String, String>> _pages = [
    {
      "image": "assets/images/fp1.png",
      "title": "Get ready to unlock the",
      "subtitle": "best deals"
    },
    {
      "image": "assets/images/fp2.png",
      "title": "Delivered at",
      "subtitle": "lightning speed"
    },
    {
      "image": "assets/images/fp3.png",
      "title": "Dedicated",
      "subtitle": "pet relationship manager"
    },
    {
      "image": "assets/images/fp4.png",
      "title": "Instead call with your",
      "subtitle": "trusted family vet"
    },
  ];

  void _onNextPressed() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()),);
    }
  }

  void _navigateToSignUp() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SignUpScreen()));
  }

  Widget _buildDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 16 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.greenAccent : Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.65 : screenHeight*0.80,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth*0.05 : screenWidth*0.10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            page["image"]!,
                            height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.4 : screenHeight*0.50,
                            width: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth*0.90 : screenWidth*0.40,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            page["title"]!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).appBarTheme.foregroundColor,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.1,
                            ),
                            child: Text(
                              page["subtitle"]!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                      (index) => _buildDot(index == _currentPage),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth*0.05 : screenWidth*0.10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _onNextPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth*0.35 : screenWidth*0.25,
                          vertical: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.025 : screenHeight*0.05,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1 ? "Login" : "Next",
                        style: const TextStyle(
                          color: Color(0xFF1E2433),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _navigateToSignUp,
                      child: Text(
                        "Sign Up",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
