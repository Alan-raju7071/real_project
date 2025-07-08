import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/view/Forgot_password/Forgot_password.dart';
import 'package:real_project/view/Register_screen/Register_screen.dart';
import 'package:real_project/widgets/Custom_Textfield.dart';
import 'package:real_project/widgets/Custom_image_container.dart';
import 'package:real_project/widgets/custom_button.dart';
import 'package:real_project/contoller/Login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); 
  bool rememberMe = false;
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // ✅ Attach the form key
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

                // Email Field
                Text(
                  TextConstants.email,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField(
                  label: "Enter your email address",
                  controller: loginProvider.emailController, // ✅ Important
                  labelColor: Colorconstants.primarygrey,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Password Field
                Text(
                  TextConstants.password,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextField(
                  label: "Enter your password",
                  controller: loginProvider.passwordController,
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

                const SizedBox(height: 20),

                // Remember Me & Forgot Password
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPassword()),
                        );
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

                // Login Button
                loginProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            loginProvider.onLogin(context); // ✅ Only if valid
                          }
                        },
                        child: CustomButton(
                          text: TextConstants.login,
                          color: Colorconstants.primaryblue,
                        ),
                      ),

                const SizedBox(height: 20),

                // Register Option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(TextConstants.dontacoount),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Text(
                        TextConstants.register,
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
        ),
      ),
    );
  }
}
