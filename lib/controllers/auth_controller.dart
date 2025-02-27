import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  //login method
  Future<UserCredential?> loginMethod({email, password}) async{
    UserCredential? userCredential;
    try{
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      if(userCredential.user !=null && !userCredential.user!.emailVerified){
        Get.snackbar("","",
          titleText: const Text("Warning", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
          messageText: const Text("Please verify your email before you log in.", style: TextStyle(fontSize: 16, color: Colors.black),),
          backgroundColor: Colors.white,
        );
        return null;
      }
    } on FirebaseAuthException catch(e){
      Get.snackbar("","",
        titleText: const Text("Error", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
        messageText: Text("$e", style: const TextStyle(fontSize: 16, color: Colors.black),),
        backgroundColor: Colors.white,
      );
    }
    return userCredential;
  }


  //signup method
  Future<UserCredential?> signupMethod({email, password}) async{
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);

      await storeUserData(email: email, password: password);

      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification().then((value){
          Get.snackbar("","",
            titleText: const Text("Verification email sent", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
            messageText: const Text("Please check your inbox.", style: TextStyle(fontSize: 16, color: Colors.black),),
            backgroundColor: Colors.white,
          );
        }); // Send verification email
      }
    } on FirebaseAuthException catch(e){
      Get.snackbar("","",
        titleText: const Text("Error", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
        messageText: Text("$e", style: const TextStyle(fontSize: 16, color: Colors.black),),
        backgroundColor: Colors.white,
      );
    }
    return userCredential;
  }

  //storing data
  Future<void> storeUserData({email, password}) async{
    DocumentReference store = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    await store.set({
      'email': email,
      'password': password,
      'id': FirebaseAuth.instance.currentUser!.uid,
      'name': "",
      'profileImageUrl': "",
    });
  }


  //logout method
  Future<void> logoutMethod() async{
    try{
      await FirebaseAuth.instance.signOut().then((value){
        Get.snackbar("","",
          titleText: const Text("successfully logout", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
          backgroundColor: Colors.white,
        );
      });
    }catch(e){
      Get.snackbar("","",
        titleText: const Text("Error", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
        messageText: Text("$e", style: const TextStyle(fontSize: 16, color: Colors.black),),
        backgroundColor: Colors.white,
      );
    }
  }


  //reset password method
  Future<void> sendPasswordResetLink({email}) async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch(e){
      Get.snackbar("","",
        titleText: const Text("Error", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
        messageText: Text("$e", style: const TextStyle(fontSize: 16, color: Colors.black),),
        backgroundColor: Colors.white,
      );
    }
  }


}
