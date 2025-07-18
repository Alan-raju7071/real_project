import 'dart:async';
import 'package:flutter/material.dart';
import 'package:real_project/view/Dashboaerd_Homescreen/Dashboaerd_Homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:real_project/view/login_screen/Login_screen.dart';
import 'package:real_project/view/first_signup_screen/First_signup_screen.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/widgets/Custom_image_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3)); 

    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!mounted) return;

    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => isLoggedIn ? const Dashboaerd_Homescreen() : const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconstants.primarywhite,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Custom_image_container(),
            const SizedBox(height: 30),
            Text(
              TextConstants.mainhead,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colorconstants.primaryblack,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              TextConstants.subhead,
              style: TextStyle(
                fontSize: 14,
                color: Colorconstants.primarygrey,
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }
} 