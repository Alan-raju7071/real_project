import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextConstants.verify),
      ),
    );
  }
}