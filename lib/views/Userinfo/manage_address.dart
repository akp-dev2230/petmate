import 'package:flutter/material.dart';
import 'package:petmate/background.dart';

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
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: screenWidth*0.03, vertical: screenHeight*0.02),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withAlpha((255 * 0.2).toInt()),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: screenWidth*0.02),
                    Text(
                      "Add Address",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
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