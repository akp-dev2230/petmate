import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {

  final uid = FirebaseAuth.instance.currentUser?.uid;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  RxString selectedGender = "".obs;

  Rx<Uint8List?> selectedImage = Rx<Uint8List?>(null);
  String filePath = '';

  void changeGender({required String gender}){
    selectedGender.value = gender;
  }

  // Method for selecting a profile photo.
  Future<void> pickPhoto() async {
    if (uid == null) return;

    try {
      // Let the user pick a new image from the gallery.
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        // Read the file as bytes.
        selectedImage.value = await pickedImage.readAsBytes();
        final String fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.png';
        filePath = '$uid/$fileName';
      }
    } catch (e) {
      Get.snackbar("","",
        titleText: const Text("Oops!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
        messageText: Text("Unable to select profile photo: $e", style: const TextStyle(fontSize: 16, color: Colors.black),),
        backgroundColor: Colors.white,
      );
    }
  }


  // Method for update profile details
  Future<void> updateProfileDetails() async {
    if (uid == null) return;

    // Map to hold fields that need to be updated.
    Map<String, dynamic> updateData = {};

    // Check if a new photo is selected.
    if (selectedImage.value != null) {
      // Remove existing files from Supabase storage.
      final List<FileObject> existingFiles = await Supabase.instance.client.storage.from('profile-images').list(path: uid);
      if (existingFiles.isNotEmpty) {
        final List<String> filePathsToDelete = existingFiles.map((file) => '$uid/${file.name}').toList();
        await Supabase.instance.client.storage.from('profile-images').remove(filePathsToDelete);
      }
      // Upload the new image.
      await Supabase.instance.client.storage.from('profile-images').uploadBinary(filePath, selectedImage.value!);
      // Retrieve the public URL for the new image.
      final String imageUrl = Supabase.instance.client.storage.from('profile-images').getPublicUrl(filePath);
      updateData['profileImageUrl'] = imageUrl;
    }

    // Only update name if a new name is provided.
    if (nameController.text.trim().isNotEmpty) {
      updateData['name'] = nameController.text.trim();
    }

    // Only update phone if a new phone number is provided.
    if (phoneController.text.trim().isNotEmpty) {
      updateData['phone'] = phoneController.text.trim();
    }

    // Update gender if a value is selected.
    if (selectedGender.value.trim().isNotEmpty) {
      updateData['gender'] = selectedGender.value.trim();
    }

    // If there is any data to update, update the Firestore document.
    if (updateData.isNotEmpty) {
      await FirebaseFirestore.instance.collection("users").doc(uid).update(updateData);
      Get.snackbar("","",
        titleText: const Text("Success", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
        messageText: const Text("Profile updated successfully!", style: TextStyle(fontSize: 16, color: Colors.black),),
        backgroundColor: Colors.white,
      );
    }
  }



}
