import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_project/view/first_signup_screen/First_signup_screen.dart';

class LoginProvider with ChangeNotifier {
  final passwordController = TextEditingController();
  bool isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> onLogin(BuildContext context) async {
    final password = passwordController.text.trim();

    if (password.isEmpty) {
      _showSnackbar(context, "Please enter your password");
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      final snapshot = await _firestore
          .collection('users')
          .where('password', isEqualTo: password)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FirstSignupScreen()),
        );
      } else {
        _showSnackbar(context, "Invalid password");
      }
    } catch (e) {
      _showSnackbar(context, 'Login failed: ${e.toString()}');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
