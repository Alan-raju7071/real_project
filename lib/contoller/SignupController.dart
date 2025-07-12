import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class SignupController {
  static Future<String?> uploadProfileImage({
    required File? fileImage,
    required Uint8List? webImageBytes,
  }) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      UploadTask uploadTask;

      if (kIsWeb && webImageBytes != null) {
        uploadTask = storageRef.putData(webImageBytes);
      } else if (fileImage != null) {
        uploadTask = storageRef.putFile(fileImage);
      } else {
        return null;
      }

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint("Error uploading image: $e");
      return null;
    }
  }

  static Future<bool> saveUserData({
  required String email,           
  required String password,
  required String dob,
  required String gender,
  required String location,
  required String address,
  required String qualification,
  required String occupation,
  required String referralCode,
  String? imageUrl,
}) async {
  try {
    
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    
    final userData = {
      'email': email,
      'dob': dob,
      'gender': gender,
      'location': location,
      'address': address,
      'qualification': qualification,
      'occupation': occupation,
      'referralCode': referralCode,
      'profileImage': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance.collection('users').doc(email).set(userData);
    return true;
  } catch (e) {
    debugPrint("Error saving user data: $e");
    return false;
  }
}

}
