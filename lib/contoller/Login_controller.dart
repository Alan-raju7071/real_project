import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:real_project/view/first_signup_screen/First_signup_screen.dart';
import 'package:real_project/view/login_screen/Login_screen.dart';

class LoginProvider with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  /// Login user
  Future<void> onLogin(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar(context, "Please enter email and password");
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _showSnackbar(context, "Enter a valid email address");
      return;
    }

    if (password.length < 6) {
      _showSnackbar(context, "Password must be at least 6 characters");
      return;
    }

    try {
      _setLoading(true);

      // Sign in with Firebase Auth
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Store login flag in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      _showSnackbar(context, "Login Successful");

      clearControllers();

      // Navigate to first signup or home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FirstSignupScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Login failed";
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address.';
      }
      _showSnackbar(context, message);
    } catch (e) {
      _showSnackbar(context, 'An unexpected error occurred');
    } finally {
      _setLoading(false);
    }
  }

  /// Set loading state
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  /// Show a snackbar
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  /// Clear input controllers
  void clearControllers() {
    emailController.clear();
    passwordController.clear();
  }

  /// Dispose controllers
  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  /// Logout and clear login state
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }
}
