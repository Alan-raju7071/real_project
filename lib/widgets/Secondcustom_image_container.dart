import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';

class seconcustomimage_container extends StatelessWidget {
  const seconcustomimage_container({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container( height: MediaQuery.of(context).size.height * 0.30, 
              width: MediaQuery.of(context).size.width * 0.7,     
      decoration: BoxDecoration(
        color: Colorconstants.blueAccent,
    //    image: DecorationImage(image: NetworkImage(""))
      ),
    );
  }
}