import 'package:flutter/material.dart';

class Custom_image_container extends StatelessWidget {
  const Custom_image_container({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     width: MediaQuery.of(context).size.width * 0.25,
     height: MediaQuery.of(context).size.width * 0.25,
    
      decoration: const BoxDecoration(
        color: Colors.red,
        
        // image: DecorationImage(image: AssetImage("assets/images/your_logo.png"))
      ),
    );
  }
}
