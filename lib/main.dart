import 'package:flutter/material.dart';
import 'package:real_project/view/Forgot_password/Forgot_password.dart';
import 'package:real_project/view/Splash_screen/Splash_screen.dart';
import 'package:real_project/view/login_screen/Login_screen.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ForgotPassword()
      
    );
  }
}
void main(){
  runApp(Myapp());
}