import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petmate/background.dart';
import 'package:petmate/commonwidgets/commontextfield.dart';

class Editaddress extends StatefulWidget {
  const Editaddress({super.key});

  @override
  State<Editaddress> createState() => _EditaddressState();
}

class _EditaddressState extends State<Editaddress> {

  // Controllers for input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController petnameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  @override
    Widget build(BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      return Scaffold(
        appBar: AppBar(
          title: const Text("Add Address"),
          centerTitle: true,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: backGround(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.035, vertical: screenHeight*0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contact Details Section
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight*0.02),
                  child: const Text("Contact Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01,
                      vertical: screenHeight * 0.005),
                  child: commonTextfield(context: context,
                    controller: nameController,
                    hinttext: "Name",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01,
                      vertical: screenHeight * 0.005),
                  child: commonTextfield(context: context,
                    controller: mobileController,
                    hinttext: "Mobile No",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01,
                      vertical: screenHeight * 0.005),
                  child: commonTextfield(context: context,
                    controller: petnameController,
                    hinttext: "Your pet's name",
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Address Section
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight*0.02),
                  child: const Text("Address", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01,
                      vertical: screenHeight * 0.005),
                  child: commonTextfield(context: context,
                    controller: addressController,
                    hinttext: "Address(Flat No/Colony)*",
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.01,
                          vertical: screenHeight * 0.005),
                      child: commonTextfield(context: context,
                        controller: pincodeController,
                        hinttext: "Pincode*",
                      ),
                    ),),
                    SizedBox(width: screenWidth*0.002),
                    Expanded(child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.01,
                          vertical: screenHeight * 0.005),
                      child: commonTextfield(context: context,
                        controller: cityController,
                        hinttext: "City/Town*",
                      ),
                    ),),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01,
                      vertical: screenHeight * 0.005),
                  child: commonTextfield(context: context,
                    controller: stateController,
                    hinttext: "State",
                  ),
                ),

                SizedBox(height: screenHeight*0.01),

                // Save Address Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF452c63),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("SAVE ADDRESS",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
}
