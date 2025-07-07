import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/widgets/Custom_Textfield.dart';
import 'package:real_project/widgets/custom_button.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(TextConstants.Forgotpassword,style: TextStyle( color: Colorconstants.primaryblack,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,),),
            ),
                    SizedBox(height: 20,),
                    Center(
                      child: Container( height: MediaQuery.of(context).size.height * 0.30, 
          width: MediaQuery.of(context).size.width * 0.7,     
                        decoration: BoxDecoration(
                          color: Colorconstants.blueAccent,
                      //    image: DecorationImage(image: NetworkImage(""))
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(TextConstants.Enteremail,style: TextStyle(fontWeight: FontWeight.bold),),
                     SizedBox(height: 20,),
                     Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(TextConstants.email,style: TextStyle(fontWeight: FontWeight.bold),),

                     CustomTextField(
                  label: "Enter email address",
                  labelColor: Colorconstants.primarygrey,
                  keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email address is required';
                    }

    
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter a valid email address';
                    }

                    return null; 
                  },
                ),
                 SizedBox(height: 20,),
                 CustomButton(text: TextConstants.verifyemail, color:  Colorconstants.primaryblue)

                     ],)
          ],
        ),
      ),
    );
  }
}