import 'package:flutter/material.dart';
import 'package:real_project/view/Splash_screen/Splash_screen.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      
    );
  }
}
void main(){
  runApp(Myapp());
}