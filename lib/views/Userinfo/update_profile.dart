import 'package:flutter/material.dart';
import 'package:petmate/background.dart';
import 'package:petmate/controllers/profile_controller.dart';
import 'package:get/get.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedGender = "Female";

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());

    final screenWidth  = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: backGround(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05, vertical: screenHeight*0.05),
              child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05, vertical: screenHeight*0.05),
                    child: Column(
                      children: [
                        // Title
                        Text(
                          "Update Profile",
                          style: Theme.of(context).textTheme.bodyLarge
                        ),
                        SizedBox(height: screenHeight*0.02),
            
                        // Avatar with camera icon overlay
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Profile image
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                              AssetImage("assets/images/user_placeholder.jpg"),
                              // You can use NetworkImage or FileImage as needed
                            ),
            
                            // Camera icon
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 18,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Color(0xFF0b5394),
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    controller.pickAndUploadPhoto();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
            
                        SizedBox(height: screenHeight*0.03),
            
                        // Name TextField
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: "Name",
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                            prefixIcon: const Icon(Icons.person, color: Color(0xFF0b5394)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          style: Theme.of(context).textTheme.bodyMedium
                        ),
                        SizedBox(height: screenHeight*0.015),
            
                        // Email TextField
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "Email Address",
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                            prefixIcon: const Icon(Icons.email, color: Color(0xFF0b5394)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight*0.015),
            
                        // Gender Row (Radio Buttons)
                        Row(
                          children: [
                            const Icon(Icons.transgender, color: Colors.orange),
                            const SizedBox(width: 8),
                            const Text(
                              "Gender",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
            
                            // Male
                            Radio<String>(
                              value: "Male",
                              activeColor: const Color(0xFF0b5394),
                              groupValue: _selectedGender,
                              onChanged: (val) {
                                setState(() {
                                  _selectedGender = val ?? "Male";
                                });
                              },
                            ),
                            const Text("Male"),
            
                            // Female
                            Radio<String>(
                              value: "Female",
                              activeColor: const Color(0xFF0b5394),
                              groupValue: _selectedGender,
                              onChanged: (val) {
                                setState(() {
                                  _selectedGender = val ?? "Female";
                                });
                              },
                            ),
                            const Text("Female"),
                          ],
                        ),
                        SizedBox(height: screenHeight*0.015),
            
                        // Contact Number
                        TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Contact Number",
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                            prefixIcon: const Icon(Icons.phone, color: Color(0xFF0b5394)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight*0.03),
            
                        // Update Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0b5394),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "UPDATE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                fontSize: 16,
                                color: Colors.white70
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          ),
        ),
      ),
    );
  }
}