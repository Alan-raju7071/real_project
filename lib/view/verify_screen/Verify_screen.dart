import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/view/login_screen/Login_screen.dart';
import 'package:real_project/widgets/custom_button.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextConstants.verify),
      ),
      body: Column(
        children: [
          Spacer(),
          InkWell(
             onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: CustomButton(text: TextConstants.continu, color: Colorconstants.primaryblue))
        ],
      ),
    );
  }
}