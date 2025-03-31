import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/background.dart';
import 'package:petmate/views/authentication_screen/loginscreen.dart';

import '../../Services/firestore_services.dart';

class Admininfo extends StatefulWidget {
  const Admininfo({super.key});

  @override
  State<Admininfo> createState() => _AdmininfoState();
}

class _AdmininfoState extends State<Admininfo> {
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final profileIcons = [Icons.person, Icons.policy, Icons.help_outline];
    final profileIconsTitle = ["Profile", "Privacy policy", "Help and support",];
    final  profileScreens = [
      const Placeholder(),
      const Placeholder(),
      const Placeholder(),
      const Placeholder(),
      const Placeholder(),
      const Placeholder(),
    ];

    return Scaffold(
      body: backGround(
        child: FutureBuilder(
          future: FirestoreServices.getAdmin(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color(0xFF073763)),),
              );
            }else if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
              return Center(
                child: Text("No Admin Found", style: Theme.of(context).textTheme.bodyLarge,),
              );
            }else{
              var data = snapshot.data!.docs[0];
              return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile Information
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: (data['profileImageUrl'] != null && data['profileImageUrl'].toString().isNotEmpty)
                              ? NetworkImage(data['profileImageUrl'])
                              : const AssetImage("assets/images/appTempPhoto.jpg") as ImageProvider,
                        ),
                        SizedBox(height: screenHeight*0.02),
                        Text("${data['email']}", style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight*0.03),
                    // Settings Options
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05),
                      child: Card(
                        elevation: 2.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: profileIconsTitle.length,
                              itemBuilder: (context, index){
                                return ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFeeeeee),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(profileIcons[index], color: const Color(0xFF0b5394),),
                                  ),
                                  title: Text(profileIconsTitle[index], style: const TextStyle(fontSize: 18, color: Colors.black),),
                                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black,),
                                  onTap: (){
                                    Get.to(profileScreens[index]);
                                  },
                                );
                              },
                            ),
                            const Divider(),
                            ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withAlpha(25),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(Icons.logout, color: Colors.red,),
                              ),
                              title: const Text(
                                "Log out",
                                style: TextStyle(color: Colors.red),
                              ),
                              onTap: () async {
                                await FirebaseAuth.instance.signOut().then((value) {
                                  Get.off(const LoginScreen());
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
