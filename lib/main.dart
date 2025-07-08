import 'package:flutter/material.dart';
import 'package:real_project/view/Forgot_password/Forgot_password.dart';
import 'package:real_project/view/Password_reset_successfull/Password_reset_successfull.dart';
import 'package:real_project/view/Register_screen/Register_screen.dart';
import 'package:real_project/view/Reset_password/Reset_Password.dart';
import 'package:real_project/view/Splash_screen/Splash_screen.dart';
import 'package:real_project/view/Verify_email_address/Verify_email_address.dart';
import 'package:real_project/view/first_signup_screen/First_signup_screen.dart';
import 'package:real_project/view/login_screen/Login_screen.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstSignupScreen()
      
    );
  }
}
void main(){
  runApp(Myapp());
}