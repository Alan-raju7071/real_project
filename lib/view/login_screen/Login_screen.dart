import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/view/Forgot_password/Forgot_password.dart';
import 'package:real_project/widgets/Custom_Textfield.dart';
import 'package:real_project/widgets/Custom_image_container.dart';
import 'package:real_project/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Text(
                TextConstants.loginhead,
                style: TextStyle(
                  color: Colorconstants.primaryblack,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(child: Custom_image_container()),
             const SizedBox(height: 10),
            Text(
              TextConstants.mainhead,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              TextConstants.logincontinue,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextConstants.mobilenumber,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField(
                  label: "Enter your mobile number",
                  labelColor: Colorconstants.primarygrey,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  TextConstants.password,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
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
                const SizedBox(height: 20),

                
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),
                    const SizedBox(width: 4),
                    Text(
                      TextConstants.remembberme,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));
                      },
                      child: Text(
                        TextConstants.forgotpassword,
                        style: TextStyle(
                          color: Colorconstants.blueAccent,
                          decoration: TextDecoration.underline,
                          decorationColor: Colorconstants.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                
                InkWell(
                  onTap: () {
                  
                  },
                  child: CustomButton(text: TextConstants.login, color: Colorconstants.primaryblue),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(TextConstants.dontacoount),
                     TextButton(
                      onPressed: () {
                        
                        Navigator.pop(context);
                      },
                       child: TextButton(
                        onPressed: () {
                          // Navigator.push(context,
                          //  MaterialPageRoute(builder: (context) => RegistrationScreen(),));
                        },
                         child: Text(TextConstants.register,
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
          ],
        ),
      ),
    );
  }
}

