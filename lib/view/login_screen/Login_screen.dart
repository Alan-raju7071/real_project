import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/view/ForgotPasswordWithOTP/ForgotPasswordWithOTP.dart';
import 'package:real_project/view/first_signup_screen/First_signup_screen.dart';
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
  bool isEmailLogin = true;
final mobileController = TextEditingController();
final otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      backgroundColor: Colorconstants.primarywhite,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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

                
                Center(
                  child: Column(
                    children: [
                      Text(
                        TextConstants.mainhead,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        TextConstants.logincontinue,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                
                if (isEmailLogin) ...[
  Text(TextConstants.email, style: const TextStyle(fontWeight: FontWeight.bold)),
  CustomTextField(
    label: "Enter your email address",
    controller: loginProvider.emailController,
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
  Text(TextConstants.password, style: const TextStyle(fontWeight: FontWeight.bold)),
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
  SizedBox(height: 10,)
] else ...[
  const Text(TextConstants.mobilenumber, style: TextStyle(fontWeight: FontWeight.bold)),
  CustomTextField(
    label: "Enter your mobile number",
    controller: mobileController,
    keyboardType: TextInputType.phone,
    labelColor: Colorconstants.primarygrey,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Enter your mobile number';
      }
      if (value.length != 10) {
        return 'Mobile number should be 10 digits';
      }
      return null;
    },
  ),
  const SizedBox(height: 16),
  const Text(TextConstants.oTP, style: TextStyle(fontWeight: FontWeight.bold)),
  CustomTextField(
    label: "Enter OTP",
    controller: otpController,
    keyboardType: TextInputType.number,
    labelColor: Colorconstants.primarygrey,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Enter OTP';
      }
      return null;
    },
  ),
  const SizedBox(height: 10),
  Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () {
        
      },
      child: const Text(TextConstants.sendOTP),
    ),
  ),
],

                Center(
  child: TextButton.icon(
    onPressed: () {
      setState(() {
        isEmailLogin = !isEmailLogin;
      });
    },
    icon: Icon(isEmailLogin ? Icons.phone_android : Icons.email),
    label: Text(
      isEmailLogin ? TextConstants.mobile : TextConstants.em,
      style: TextStyle(
        color: Colorconstants.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
const SizedBox(height: 10),

                const SizedBox(height: 20),

                
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                    ),
                    Text(
                      TextConstants.remembberme,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ForgotPasswordWithOTP()),
                        );
                      },
                      child: Text(
                        TextConstants.forgotpassword,
                        style: TextStyle(
                          color: Colorconstants.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                
                loginProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : InkWell(
                        onTap: () {
  if (_formKey.currentState!.validate()) {
    if (isEmailLogin) {
      loginProvider.onLogin(context); 
    } else {
     
    }
  }
},

                        child: CustomButton(
                          text: TextConstants.login,
                          color: Colorconstants.primaryblue,
                        ),
                      ),

                const SizedBox(height: 20),

              
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(TextConstants.dontacoount),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FirstSignupScreen()),
                        );
                      },
                      child: Text(
                        TextConstants.register,
                        style: TextStyle(
                          color: Colorconstants.blueAccent,
                          decoration: TextDecoration.underline,
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
