import 'package:flutter/material.dart';
import 'package:petmate/background.dart';
import 'package:petmate/commonwidgets/commontextfield.dart';

class ManageAddress extends StatefulWidget {
  const ManageAddress({super.key});

  @override
  State<ManageAddress> createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  final List<Map<String, String>> addresses = [
    {
      "label": "Home",
      "addressLine": "123 Main Street, City, Country",
    },
    {
      "label": "Office",
      "addressLine": "123 Main Street, City, Country",
    },
  ];


  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
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
        title: const Text("My Addresses"),
      ),
      body: backGround(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth*0.04, vertical: screenHeight*0.03),
          child: Column(
            children: [
              SizedBox(
                width: screenWidth * 0.8, // 80% of screen width
                height: screenHeight*0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Transparent background
                    shadowColor: Colors.transparent, // Remove shadow
                    padding: EdgeInsets.zero, // Remove extra padding
                  ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // Makes modal take full height if needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
                            ),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                                vertical: screenHeight * 0.03,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min, // Adjusts height dynamically
                                children: [
                                  // Contact Details Section
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
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
                                      controller: nameController,
                                      hinttext: "Name",
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.01,
                                        vertical: screenHeight * 0.005),
                                    child: commonTextfield(
                                      context: context,
                                      controller: mobileController,
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
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.01,
                                        vertical: screenHeight * 0.005),
                                    child: commonTextfield(
                                      context: context,
                                      controller: addressController,
                                      hinttext: "Address (Flat No/Colony)*",
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
                                            controller: pincodeController,
                                            hinttext: "Pincode*",
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
                                            controller: cityController,
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
                                      controller: stateController,
                                      hinttext: "State",
                                    ),
                                  ),

                                  SizedBox(height: screenHeight * 0.01),

                                  // Save Address Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context); // Close modal on save
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF073763),
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
                          );
                        },
                      );
                    },
                    child: Text("Add Address", style: Theme.of(context).textTheme.titleMedium,),
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
                    Column(
                      children: addresses.map((addr) {
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
                                      addr["label"] ?? "",
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    SizedBox(width: screenWidth*0.03),
                                    Text(
                                      addr["addressLine"] ?? "",
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
                                    // Add your edit logic here
                                    print('Edit clicked for ${addr["label"]}');
                                  } else if (result == 'delete') {
                                    // Add your delete logic here
                                    print('Delete clicked for ${addr["label"]}');
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
                                offset: Offset(0, 40), // Adjusts vertical position relative to icon
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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