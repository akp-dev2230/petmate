import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petmate/background.dart';
import '../../Services/firestore_services.dart';

class Clinic extends StatelessWidget {
  const Clinic({super.key, this.specialty});

  final String? specialty;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.025, vertical: screenHeight*0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Meet Our Fear-Free Certified Team", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: screenHeight*0.01,),
                Text("Dermatologist", style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: screenHeight*0.01,),
                Column(
                  children: [
                    StreamBuilder(
                      stream: FirestoreServices.getDoctors("Dermatologist"),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Color(0xFF073763)),
                            ),
                          );
                        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text("No doctors found", style: Theme.of(context).textTheme.bodyLarge),
                          );
                        } else {
                          var data = snapshot.data!.docs;

                          return Container(
                            height: screenHeight*0.45,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth*0.02, vertical: screenHeight*0.02),
                                    child: Container(
                                      width: screenWidth*0.6,
                                      padding: EdgeInsets.symmetric(horizontal: screenWidth*0.04, vertical: screenHeight*0.02),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(3, 3),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Column(
                                        children: [
                                          ClipOval(
                                            child: Image.network(
                                              data[index]['imageUrl'],
                                              width: 130,
                                              height: 130,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(height: screenHeight*0.01),
                                          Text(
                                            data[index]['name'], style: Theme.of(context).textTheme.bodySmall),
                                          SizedBox(height: screenHeight*0.01),
                                          Text(
                                            "${data[index]['experience']} years of experience", // Removed toStringAsFixed
                                              style: Theme.of(context).textTheme.bodySmall,),
                                          SizedBox(height: screenHeight*0.01),
                                          Text(
                                            "${data[index]['specialty']}", // Removed toStringAsFixed
                                              style: Theme.of(context).textTheme.bodySmall),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: screenHeight*0.01,),
                Text("Nutritionist", style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: screenHeight*0.01,),
                Column(
                  children: [
                    StreamBuilder(
                      stream: FirestoreServices.getDoctors("Nutritionist"),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Color(0xFF073763)),
                            ),
                          );
                        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text("No doctors found", style: Theme.of(context).textTheme.bodyLarge),
                          );
                        } else {
                          var data = snapshot.data!.docs;

                          return Container(
                            height: screenHeight*0.45,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth*0.02, vertical: screenHeight*0.02),
                                    child: Container(
                                      width: screenWidth*0.6,
                                      padding: EdgeInsets.symmetric(horizontal: screenWidth*0.04, vertical: screenHeight*0.02),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(3, 3),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            data[index]['imageUrl'],
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(height: screenHeight*0.01),
                                          Text(
                                              data[index]['name'], style: Theme.of(context).textTheme.bodySmall),
                                          SizedBox(height: screenHeight*0.01),
                                          Text(
                                            "${data[index]['experience']} years of experience", // Removed toStringAsFixed
                                            style: Theme.of(context).textTheme.bodySmall,),
                                          SizedBox(height: screenHeight*0.01),
                                          Text(
                                              "${data[index]['specialty']}", // Removed toStringAsFixed
                                              style: Theme.of(context).textTheme.bodySmall),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: screenHeight*0.01,),
                Text("Pathologist", style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: screenHeight*0.01,),
                Column(
                  children: [
                    StreamBuilder(
                      stream: FirestoreServices.getDoctors("Pathologist"),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Color(0xFF073763)),
                            ),
                          );
                        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text("No doctors found", style: Theme.of(context).textTheme.bodyLarge),
                          );
                        } else {
                          var data = snapshot.data!.docs;

                          return Container(
                            height: screenHeight*0.45,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth*0.02, vertical: screenHeight*0.02),
                                    child: Container(
                                      width: screenWidth*0.6,
                                      padding: EdgeInsets.symmetric(horizontal: screenWidth*0.04, vertical: screenHeight*0.02),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(3, 3),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            data[index]['imageUrl'],
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(height: screenHeight*0.01),
                                          Text(
                                              data[index]['name'], style: Theme.of(context).textTheme.bodySmall),
                                          SizedBox(height: screenHeight*0.01),
                                          Text(
                                            "${data[index]['experience']} years of experience", // Removed toStringAsFixed
                                            style: Theme.of(context).textTheme.bodySmall,),
                                          SizedBox(height: screenHeight*0.01),
                                          Text(
                                              "${data[index]['specialty']}", // Removed toStringAsFixed
                                              style: Theme.of(context).textTheme.bodySmall),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}