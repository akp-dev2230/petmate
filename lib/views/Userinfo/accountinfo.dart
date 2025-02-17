import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/Services/firestore_services.dart';
import 'package:petmate/controllers/profile_controller.dart';
import 'package:petmate/views/authentication_screen/loginscreen.dart';

class Accountinfo extends StatelessWidget {
  const Accountinfo({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final profileIcons = [Icons.account_balance, Icons.person, Icons.favorite_outline, Icons.home_filled, Icons.policy, Icons.help_outline];
    final profileIconsTitle = ["Account setup", "Profile setting", "Wishlist", "Add Address", "Privacy policy", "Help and support",];

    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: StreamBuilder(
        stream: FirestoreServices.getUser(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.greenAccent),),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return Center(
              child: Text("No User Found", style: Theme.of(context).textTheme.bodyLarge,),
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
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: (data['profileImageUrl'] != null && data['profileImageUrl'].toString().isNotEmpty)
                                ? NetworkImage(data['profileImageUrl'])
                                : const AssetImage("assets/images/bansalbhand.jpg") as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.edit, size: 30, color: Colors.orangeAccent,),
                              onPressed: (){
                                controller.pickAndUploadPhoto();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight*0.02),
                      Text("Name", style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text("${data['email']}", style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.03),
                  // Settings Options
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index){
                              return ListTile(
                                leading: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.teal.shade50,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(profileIcons[index], color: Colors.teal,),
                                ),
                                title: Text(profileIconsTitle[index], style: const TextStyle(fontSize: 18, color: Colors.black),),
                                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black,),
                                onTap: (){

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
    );
  }
}