import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {

  // Method for uploading a profile photo.
  Future<void> pickAndUploadPhoto() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      // Let the user pick a new image from the gallery.
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        // Read the file as bytes.
        final Uint8List fileBytes = await pickedImage.readAsBytes();
        final String fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.png';
        final String filePath = '$uid/$fileName';

        // Check if the user already has any files in their folder.
        final List<FileObject> existingFiles = await Supabase.instance.client.storage.from('profile-images').list(path: uid);

        if (existingFiles.isNotEmpty) {
          // Construct the full file paths for deletion.
          final List<String> filePathsToDelete = existingFiles.map((file) => '$uid/${file.name}').toList();
          // Delete all existing files for this user.
          await Supabase.instance.client.storage.from('profile-images').remove(filePathsToDelete);
        }

        // Upload the new image to Supabase.
        await Supabase.instance.client.storage.from('profile-images').uploadBinary(filePath, fileBytes);
        // Retrieve the public URL of the newly uploaded image.
        final String imageUrl = Supabase.instance.client.storage.from('profile-images').getPublicUrl(filePath);
        // Update the user's Firestore document with the new image URL
        await FirebaseFirestore.instance.collection("users").doc(uid).update({
          'profileImageUrl': imageUrl,
        });
        Get.snackbar("Success", "Profile photo updated!", backgroundColor: Colors.green, colorText: Colors.white);
      }

    } catch (e) {
      Get.snackbar("Error", "Failed to upload profile photo: $e", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

}
