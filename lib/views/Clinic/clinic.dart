import 'package:flutter/material.dart';
import 'package:petmate/background.dart';

class Clinic extends StatefulWidget {
  const Clinic({super.key});

  @override
  State<Clinic> createState() => _ClinicState();
}

class _ClinicState extends State<Clinic> {
  @override
  Widget build(BuildContext context) {

    final screenWidth  = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Care Clinic'),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: backGround(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:  EdgeInsets.only(left: screenWidth*0.035, bottom: screenHeight*0.11, right: screenWidth*0.02,top: screenHeight*0.02),
            child: Column(
              children: [
                const Text(
                  'Meet Our Fear-Free Certified Team',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.4, // Set a fixed, reasonable height
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildDoctorCard(
                          'Dr. Swathi Hareendran',
                          'Mom to Mashu, a rescue indie cat\n10 years of experience\nGeneral physician & soft tissue surgeon',
                          'assets/images/appTempPhoto.jpg',
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        _buildDoctorCard(
                          'Dr. Remya Nair',
                          'Mom to Aashu\n4 years of experience\nGeneral physician',
                          'assets/images/appTempPhoto.jpg',
                        ),
                      ],
                    ),
                  ),
                ),
        
                const Text(
                  'Your pets new safe space',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  'Experience Fear-Free veterinary care',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.4, // Set a fixed, reasonable height
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildDoctorCard(
                          'Dr. Swathi Hareendran',
                          'Mom to Mashu, a rescue indie cat\n10 years of experience\nGeneral physician & soft tissue surgeon',
                          'assets/images/appTempPhoto.jpg',
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        _buildDoctorCard(
                          'Dr. Remya Nair',
                          'Mom to Aashu\n4 years of experience\nGeneral physician',
                          'assets/images/appTempPhoto.jpg',
                        ),
                      ],
                    ),
                  ),
                ),
        
                SizedBox(height: screenHeight*0.02),
                Container(
                    width: double.infinity,
                    height: screenHeight * 0.4,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          veterinarycareCard("Vacciination Plans", context),
                          SizedBox(width: screenWidth * 0.02),
                          veterinarycareCard("Vacciination Plans", context),
                          SizedBox(width: screenWidth * 0.02),
                          veterinarycareCard("Vacciination Plans", context)
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorCard(String name, String details, String imagePath) {
    final screenWidth  = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.08,
          vertical: screenHeight * 0.03,
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(imagePath),
            ),
            SizedBox(height: screenHeight*0.01,),
            // Remove Expanded if causing layout issues in a horizontally unbounded context
            Container(
              width: screenWidth * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    details,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget veterinarycareCard(String name,context ) {

  final screenWidth  = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return Container(
    width: screenWidth*0.5,
    // Outer container for rounded corners and drop shadow
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top image with clipped corners
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              'assets/images/appTempPhoto.jpg', // Replace with your actual image path
              fit: BoxFit.cover,
              height: screenHeight*0.3, // Adjust height as desired
            ),
          ),
          // Content below the image
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.03, vertical: screenHeight*0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
  );
}

