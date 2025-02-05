import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService {


  //login method
  Future<UserCredential?> loginMethod({email, password, required BuildContext context}) async{
    UserCredential? userCredential;
    try{
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text("Error: $e", style: const TextStyle(fontSize: 16),),
      ));
    }
    return userCredential;
  }


  //signup method
  Future<UserCredential?> signupMethod({email, password, required BuildContext context}) async{
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);

      await storeUserData(email: email, password: password);

      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification().then((value){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.white,
            content: Text("Verification email sent. Please check your inbox.", style: TextStyle(fontSize: 16),),
          ));
        }); // Send verification email
      }
    } on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text("Error: $e", style: const TextStyle(fontSize: 16),),
      ));
    }
    return userCredential;
  }

  //storing data
  Future<void> storeUserData({email, password}) async{
    DocumentReference store = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    await store.set({
      'email': email,
      'password': password,
    });
  }


  //logout method
  Future<void> logoutMethod({required BuildContext context}) async{
    try{
      await FirebaseAuth.instance.signOut().then((value){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.white,
          content: Text("successfully logout", style: TextStyle(fontSize: 16),),
        ));
      });
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text("Error: $e", style: const TextStyle(fontSize: 16),),
      ));
    }
  }


  //reset password method
  Future<void> sendPasswordResetLink({email,required BuildContext context}) async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text("Error: $e", style: const TextStyle(fontSize: 16),),
      ));
    }
  }


}
