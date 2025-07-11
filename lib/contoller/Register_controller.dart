import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_project/view/Second_SignUp_screen/Second_signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:real_project/view/login_screen/Login_screen.dart';


class RegisterProvider with ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
  Future<void> registerUser(BuildContext context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackbar(context, "All fields are required");
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _showSnackbar(context, "Enter a valid email");
      return;
    }

    if (password.length < 6) {
      _showSnackbar(context, "Password must be at least 6 characters");
      return;
    }

    try {
      _setLoading(true);

      
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': name,
        'email': email,
        'createdAt': Timestamp.now(),
      });

      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      _showSnackbar(context, "Registration Successful");

      clearControllers();

      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SecondSignupScreen()),
      );
    } on FirebaseAuthException catch (e) {
      _showSnackbar(context, e.message ?? "Registration failed");
    } catch (e) {
      _showSnackbar(context, "An error occurred");
    } finally {
      _setLoading(false);
    }
  }


  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  
  void clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  
  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  
  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }
}
