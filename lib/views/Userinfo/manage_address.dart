import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/Services/firestore_services.dart';
import 'package:petmate/background.dart';
import 'package:petmate/commonwidgets/commontextfield.dart';
import 'package:petmate/controllers/profile_controller.dart';

class ManageAddress extends StatelessWidget {
  const ManageAddress({super.key});

  @override
  Widget build(BuildContext context) {

    final ProfileController profileController = Get.put(ProfileController());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Address"),
      ),
      body: backGround(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth*0.04, vertical: screenHeight*0.03),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: screenHeight*0.08,
                padding: EdgeInsets.symmetric(horizontal: screenWidth*0.02, vertical: screenHeight*0.01),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth*0.02, vertical: screenHeight*0.01),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap:() {
                      modalSheet(context);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.add, color: Color(0xFF073763),),
                        Text("  Add Address", style: Theme.of(context).textTheme.titleMedium,),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.02),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: screenWidth*0.04, vertical: screenHeight*0.02),

                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: screenHeight*0.01),
                      child: Text(
                        "SAVED ADDRESSES",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    FutureBuilder(
                      future: FirestoreServices.getAddress(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const Center(
                            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color(0xFF073763)),),
                          );
                        }else if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                           return Center(
                            child: Text("No Address Found", style: Theme.of(context).textTheme.bodyLarge,),
                          );
                        }else{
                          var addressData = snapshot.data!.docs;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: addressData.length,
                            itemBuilder: (BuildContext context, int index){
                              return Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: screenHeight*0.01),
                                padding: EdgeInsets.symmetric(horizontal: screenWidth*0.01, vertical: screenHeight*0.01),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(width: screenWidth*0.03),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            addressData[index]['name'],
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                          SizedBox(width: screenWidth*0.03),
                                          Text(
                                            addressData[index]['address'],
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                          SizedBox(width: screenWidth*0.01),
                                          Text(
                                            "${addressData[index]['city']}, ${addressData[index]['state']}, ${addressData[index]['pinCode']}",
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                          SizedBox(width: screenWidth*0.01),
                                          Text(
                                            addressData[index]['mobile'],
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuButton<String>(
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                      onSelected: (String result) {
                                        if (result == 'edit') {
                                          print(addressData[index].id);
                                        } else if (result == 'delete') {
                                          profileController.deleteAddress(addressDoc:addressData[index].id);
                                          // Add your delete logic here
                                        }
                                      },
                                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                        const PopupMenuItem<String>(
                                          value: 'edit',
                                          child: Row(
                                            children: [
                                              Icon(Icons.edit, color: Colors.black54, size: 20),
                                              SizedBox(width: 12),
                                              Text(
                                                'Edit',
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const PopupMenuItem<String>(
                                          value: 'delete',
                                          child: Row(
                                            children: [
                                              Icon(Icons.delete, color: Colors.redAccent, size: 20),
                                              SizedBox(width: 12),
                                              Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      offset: const Offset(0, 40), // Adjusts vertical position relative to icon
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> modalSheet(context){

  final ProfileController profileController = Get.put(ProfileController());

  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Makes modal take full height if needed
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // Adjusts for keyboard
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Adjusts height dynamically
              children: [
                // Contact Details Section
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02,),
                  child: const Text(
                    "Contact Details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.01,
                      vertical: screenHeight * 0.005),
                  child: commonTextfield(
                    context: context,
                    controller: profileController.addNameController,
                    hinttext: "Name",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.01,
                      vertical: screenHeight * 0.005),
                  child: commonTextfield(
                    context: context,
                    controller: profileController.addMobileController,
                    hinttext: "Mobile No",
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Address Section
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: const Text(
                    "Address",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01,
                            vertical: screenHeight * 0.005),
                        child: commonTextfield(
                          context: context,
                          controller: profileController.pinCodeController,
                          hinttext: "Pincode*",
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.002),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await profileController.getCurrentLocation();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF073763), // Dark blue background
                          foregroundColor: Colors.white, // White text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                          ),
                          elevation: 5, // Shadow effect
                        ),
                        child: const SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child:  Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: Colors.white,),
                              Text(
                                "Use my Location",
                                style: TextStyle(fontSize: 13,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01,
                            vertical: screenHeight * 0.005),
                        child: commonTextfield(
                          context: context,
                          controller: profileController.stateController,
                          hinttext: "State",
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.002),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01,
                            vertical: screenHeight * 0.005),
                        child: commonTextfield(
                          context: context,
                          controller: profileController.cityController,
                          hinttext: "City/Town*",
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.01,
                      vertical: screenHeight * 0.005),
                  child: commonTextfield(
                    context: context,
                    controller: profileController.addressController,
                    hinttext: "Address (Flat No/Colony)*",
                  ),
                ),

                SizedBox(height: screenHeight * 0.01),

                // Save Address Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      profileController.createAddress();
                      Navigator.pop(context); // Close modal on save
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF073763),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      "SAVE ADDRESS",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.02), // Extra space at bottom
              ],
            ),
          ),
        ),
      );
    },
  );
}