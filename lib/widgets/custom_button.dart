import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  

  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      
      
       Container(
       decoration: BoxDecoration(
         color: color,
         borderRadius: BorderRadius.circular(5)
       ),
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        
      
    );
  }
}
