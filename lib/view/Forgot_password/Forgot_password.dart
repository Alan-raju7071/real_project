import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/view/Verify_email_address/Verify_email_address.dart';
import 'package:real_project/widgets/Custom_Textfield.dart';
import 'package:real_project/widgets/Secondcustom_image_container.dart';
import 'package:real_project/widgets/custom_button.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  TextConstants.Forgotpassword,
                  style: TextStyle(
                    color: Colorconstants.primaryblack,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(child: seconcustomimage_container()),
              const SizedBox(height: 20),
              Text(
                TextConstants.Enteremail,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TextConstants.email,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(
                    label: "Enter email address",
                    labelColor: Colorconstants.primarygrey,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email address is required';
                      }

                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Enter a valid email address';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyEmailAddress(),
                          ),
                        );
                      }
                    },
                    child: CustomButton(
                      text: TextConstants.verifyemail,
                      color: Colorconstants.primaryblue,
                      
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
