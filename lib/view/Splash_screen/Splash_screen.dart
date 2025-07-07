import 'dart:async';
import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/view/login_screen/Login_screen.dart';
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
    
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Custom_image_container(),
          ),
          Text(
            TextConstants.mainhead,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colorconstants.primaryblack,
            ),
          ),
          Text(TextConstants.subhead),
        ],
      ),
    );
  }
}

