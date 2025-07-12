import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/view/login_screen/Login_screen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut(); 
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); 

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colorconstants.primarywhite,
        elevation: 0,
        title: const Text("Home", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: const Center(
        child: Text("Welcome to Home Screen"),
      ),
    );
  }
}
