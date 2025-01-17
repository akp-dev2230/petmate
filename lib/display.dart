import 'package:flutter/material.dart';
import 'package:petmate/loginscreen.dart';

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
      "image": "assets/images/fp1.jpeg",
      "title": "Get ready to unlock the",
      "subtitle": "best deals"
    },
    {
      "image": "assets/images/fp2.jpeg",
      "title": "Delivered at",
      "subtitle": "lightning speed"
    },
    {
      "image": "assets/images/fp3.jpeg",
      "title": "Dedicated",
      "subtitle": "pet relationship manager"
    },
    {
      "image": "assets/images/fp4.jpeg",
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
      _navigateToLogin();
    }
  }

  void _onSkipPressed() {
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Loginscreen()),
    );
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
    final isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          page["image"]!,
                          height: screenHeight * 0.4,
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        Text(
                          page["title"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isTablet ? 28 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
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
                            style: TextStyle(
                              fontSize: isTablet ? 16 : 14,
                              color: Colors.grey,
                            ),
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
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _onNextPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 40 : 32,
                            vertical: isTablet ? 18 : 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          _currentPage == _pages.length - 1 ? "Login" : "Next",
                          style: TextStyle(
                            fontSize: isTablet ? 18 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _onSkipPressed,
                    child: Text(
                      "Login later",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: isTablet ? 18 : 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }
}
