import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/view/Password_reset_successfull/Password_reset_successfull.dart';
import 'package:real_project/widgets/Custom_Textfield.dart';
import 'package:real_project/widgets/Secondcustom_image_container.dart';
import 'package:real_project/widgets/custom_button.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  void dispose() {
    newPassController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }
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
              Text(
                TextConstants.restpass,
                style: TextStyle(
                  color: Colorconstants.primaryblack,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: seconcustomimage_container(),
              ),
              Text(
                TextConstants.mustpass,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TextConstants.newpass,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(
                    controller: newPassController,
                    label: "Enter your mobile password",
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
                  const SizedBox(height: 10),
                  Text(
                    TextConstants.confpass,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(
                    controller: confirmPassController,
                    label: "Enter your mobile password",
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
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
      if (newPassController.text != confirmPassController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PasswordResetSuccessfull(),
          ),
        );
      }
    }
                  
                },
                child: CustomButton(
                  text: TextConstants.setpass,
                  color: Colorconstants.primaryblue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
