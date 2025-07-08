import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/widgets/Custom_Textfield.dart';
import 'package:real_project/widgets/Custom_image_container.dart';
import 'package:real_project/widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(TextConstants.register,
                    style: TextStyle(
                      color: Colorconstants.primaryblack,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),),
            ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Custom_image_container(),
                    
                  ),
                  Text(TextConstants.mainhead,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                Text(TextConstants.detailsbelow,style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextConstants.username,style: TextStyle(fontWeight: FontWeight.bold),),
                    CustomTextField(  label: "Enter your mobile User name",
                  labelColor: Colorconstants.primarygrey,
                  keyboardType: TextInputType.phone,
                  
                    validator: (value) {
                   if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                     }
                    return null;
                     },
                  ),
                  SizedBox(height: 10,),
                  Text(TextConstants.email,style: TextStyle(fontWeight: FontWeight.bold),),
                  CustomTextField(
                    label: "Enter your mobile Email Address",
                  labelColor: Colorconstants.primarygrey,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Enter a valid email address';
        }
        return null;
      },
                  ),
                  SizedBox(height: 10,),
                  Text(TextConstants.password,style: TextStyle(fontWeight: FontWeight.bold),),
                  CustomTextField(
                  label: "Enter your password",
                  labelColor: Colorconstants.primarygrey,
                  obscureText: !passwordVisible,
                  suffix: IconButton(
                    icon: Icon(
                      passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colorconstants.primarygrey,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10,),
                Text(TextConstants.confpass,style: TextStyle(fontWeight: FontWeight.bold),),
                  CustomTextField(
                  label: "Enter your password",
                  labelColor: Colorconstants.primarygrey,
                  obscureText: !passwordVisible,
                  suffix: IconButton(
                    icon: Icon(
                      passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colorconstants.primarygrey,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CustomButton(text: TextConstants.signup, color: Colorconstants.primaryblue),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(TextConstants.alreadyacc),
                     TextButton(
                      onPressed: () {
                        
                        Navigator.pop(context);
                      },
                       child: TextButton(
                        onPressed: () {
                          // Navigator.push(context,
                          //  MaterialPageRoute(builder: (context) => RegistrationScreen(),));
                        },
                         child: Text(TextConstants.login,
                         style: TextStyle(
                          color: Colorconstants.blueAccent,
                           decoration: TextDecoration.underline,
                        decorationColor: Colorconstants.blueAccent,

                         ),
                         ),
                       ),
                     )
                   ],
                 )
          ],
        ),
      ),
    );
  }
}