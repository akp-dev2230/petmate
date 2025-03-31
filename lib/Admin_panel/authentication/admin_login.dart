import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:petmate/Admin_panel/Home/admin_bottomnavbar.dart';
import 'package:petmate/Admin_panel/authentication/admin_signup.dart';
import 'package:petmate/background.dart';

import '../../commonwidgets/commonbutton.dart';
import '../../commonwidgets/commontextfield.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController admemailController = TextEditingController();
  final TextEditingController admpasswordController = TextEditingController();

  final allowedEmails = ['valigondakartheek4@gmail.com', 'kavyanshshukla2001@gmail.com', 'schoolsite123a@gmail.com'];

  Future<void> login() async {
    final email = admemailController.text.trim();
    final password = admpasswordController.text;

    if (!allowedEmails.contains(email)) {
      Get.snackbar("Access Denied", "This account is not authorized.");
      return;
    }

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final docRef = FirebaseFirestore.instance
          .collection('admin')
          .doc(userCredential.user!.uid);

      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        await docRef.set({
          'email': email,
          'uid': userCredential.user!.uid,
        });
      }

      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminBottomnavbar()));
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width ;
    final screenHeight = MediaQuery.of(context).size.height ;

    return Scaffold(
      body: backGround(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05, vertical: screenHeight*0.02),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight*0.15,),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth*0.30 : screenWidth*0.20,
                    height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.14 : screenHeight*0.40,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/PETMATE3.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(32), // Optional: Rounded corners
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.05 : screenHeight*0.03,),
                Text(
                  "Admin Login ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.08 : screenHeight*0.03,),
                commonTextfield(
                  controller: admemailController,
                  preFixIcon: CupertinoIcons.mail,
                  hinttext: "Email",
                  context: context,
                ),
                SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.02 : screenHeight*0.03,),
                commonTextfield(
                  controller: admpasswordController,
                  preFixIcon: CupertinoIcons.lock,
                  hinttext: "Password",
                  context: context,
                ),
                SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.05 : screenHeight*0.03,),
                commonButton(
                  width: screenWidth*0.85,
                  height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.07 : screenHeight*0.15,
                  buttonName: "Login",
                  onNavigate: ()=>login(),
                ),
                SizedBox(height: screenHeight*0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Don't have an account?  ", style: Theme.of(context).textTheme.bodySmall,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminSignup()));
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 16, color: Colors.black, decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
