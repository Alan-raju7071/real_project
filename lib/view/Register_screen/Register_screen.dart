import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/contoller/Register_controller.dart';
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
  bool confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                TextConstants.register,
                style: TextStyle(
                  color: Colorconstants.primaryblack,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Custom_image_container(),
            Text(
              TextConstants.mainhead,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              TextConstants.detailsbelow,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TextConstants.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                CustomTextField(
                  label: "Enter your username",
                  controller: registerProvider.nameController,
                  labelColor: Colorconstants.primarygrey,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Text(TextConstants.email, style: const TextStyle(fontWeight: FontWeight.bold)),
                CustomTextField(
                  label: "Enter your email address",
                  controller: registerProvider.emailController,
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
                const SizedBox(height: 10),
                Text(TextConstants.password, style: const TextStyle(fontWeight: FontWeight.bold)),
                CustomTextField(
                  label: "Enter your password",
                  controller: registerProvider.passwordController,
                  labelColor: Colorconstants.primarygrey,
                  obscureText: !passwordVisible,
                  suffix: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                Text(TextConstants.confpass, style: const TextStyle(fontWeight: FontWeight.bold)),
                CustomTextField(
                  label: "Confirm your password",
                  controller: TextEditingController(),
                  labelColor: Colorconstants.primarygrey,
                  obscureText: !confirmPasswordVisible,
                  suffix: IconButton(
                    icon: Icon(
                      confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colorconstants.primarygrey,
                    ),
                    onPressed: () {
                      setState(() {
                        confirmPasswordVisible = !confirmPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != registerProvider.passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            registerProvider.isLoading
                ? const CircularProgressIndicator()
                : InkWell(
                   onTap: () {
    registerProvider.registerUser(context);
  },
                  child: CustomButton(
                    
                      text: TextConstants.signup,
                      color: Colorconstants.primaryblue,
                     
                    ),
                ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(TextConstants.alreadyacc),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    TextConstants.login,
                    style: TextStyle(
                      color: Colorconstants.blueAccent,
                      decoration: TextDecoration.underline,
                      decorationColor: Colorconstants.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
