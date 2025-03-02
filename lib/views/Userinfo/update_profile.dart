import 'package:flutter/material.dart';
import 'package:petmate/background.dart';
import 'package:petmate/controllers/profile_controller.dart';
import 'package:get/get.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

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
                          Obx(()=>
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: controller.selectedImage.value != null
                                  ? MemoryImage(controller.selectedImage.value!)
                                  : const AssetImage("assets/images/appTempPhoto.jpg") as ImageProvider,
                            ),
                          ),

                          // Camera icon
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 18,
                              child: IconButton(
                                icon: const Icon(Icons.photo_library, color: Color(0xFF0b5394), size: 18,),
                                onPressed: () {
                                  controller.pickPhoto();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight*0.03),

                      // Name TextField
                      TextField(
                          controller: controller.nameController,
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

                      // Contact Number
                      TextField(
                        controller: controller.phoneController,
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

                      SizedBox(height: screenHeight*0.015),

                      // Gender Row (Radio Buttons)

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Obx(()=>
                          Row(
                              children: [
                                const Icon(Icons.transgender, color: Colors.orange),
                                const Text("Gender", style: TextStyle(fontWeight: FontWeight.w600),),
                                // Male
                                Radio<String>(
                                  value: "Male",
                                  activeColor: const Color(0xFF0b5394),
                                  groupValue: controller.selectedGender.value,
                                  onChanged: (val) {
                                    controller.changeGender(gender: val!);
                                  },
                                ),
                                const Text("Male"),

                                // Female
                                Radio<String>(
                                  value: "Female",
                                  activeColor: const Color(0xFF0b5394),
                                  groupValue: controller.selectedGender.value,
                                  onChanged: (val) {
                                    controller.changeGender(gender: val!);
                                  },
                                ),
                                const Text("Female"),
                              ],
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
                          onPressed: () {
                            controller.updateProfileDetails();
                            Get.back();
                          },
                          child: const Text("UPDATE", style: TextStyle(fontSize: 18, color: Color(0xFFf3f4f6)),),
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
