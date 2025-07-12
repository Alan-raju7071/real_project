import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:location/location.dart';
 import 'dart:html' as html;

import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/contoller/Autofillcontriller.dart';
import 'package:real_project/contoller/SignupController.dart';
import 'package:real_project/view/Interest_screen/Interest_screen.dart';
import 'package:real_project/widgets/Custom_Textfield.dart';
import 'package:real_project/widgets/ProfileImagePicker.dart';
import 'package:real_project/widgets/User_details_container.dart';



import 'package:real_project/widgets/custom_button.dart';
import 'package:real_project/widgets/linear_indicator_with_text.dart';

String? formatDateAndAge(DateTime date) {
  final now = DateTime.now();
  int age = now.year - date.year;
  if (now.month < date.month || (now.month == date.month && now.day < date.day)) {
    age--;
  }
  return (age >= 16) ? "${DateFormat('dd/MM/yyyy').format(date)} (Age: $age)" : null;
}

class FirstSignupScreen extends StatefulWidget {
  const FirstSignupScreen({super.key});

  @override
  State<FirstSignupScreen> createState() => FirstSignupScreenState();
}

class FirstSignupScreenState extends State<FirstSignupScreen> {
  final int currentStep = 0;
  final List<String> steps = ['Personal Info', 'Interests', 'Verify'];
  
List<String> qualificationOptions = [
  'High School',
  'Bachelor’s Degree',
  'Master’s Degree',
  'PhD',
  'Diploma',
  'Other'
];
bool showQualificationDropdown = false;


  final TextEditingController occupationController = TextEditingController();
  final TextEditingController otherQualificationController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
final TextEditingController otpController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();
final TextEditingController emailController = TextEditingController();




  final _formKey = GlobalKey<FormState>();
 String city = '', state = '', pincode = '';
  String? selectedGender;
  File? profileImage;
  Uint8List? webImageBytes;
  String? selectedCountry;
  String? verificationId;
bool otpSent = false;


  String? getFinalQualification() {
    final trimmed = otherQualificationController.text.trim();
    return trimmed.isNotEmpty ? trimmed : null;
  }
  void sendOtp() async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: "+91${mobileController.text.trim()}",
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {
      showMessage("OTP sending failed: ${e.message}");
    },
    codeSent: (String verId, int? resendToken) {
      setState(() {
        verificationId = verId;
        otpSent = true;
      });
      showMessage("OTP has been sent to your number.");
    },
    codeAutoRetrievalTimeout: (String verId) {
      verificationId = verId;
    },
    timeout: const Duration(seconds: 60),
  );
}

  

  Future<void> pickImage() async {
    try {
      if (kIsWeb) {
        final result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result != null && result.files.single.bytes != null) {
          if (!mounted) return;
          setState(() {
            webImageBytes = result.files.single.bytes!;
            profileImage = null;
          });
        }
      } else {
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          if (!mounted) return;
          setState(() {
            profileImage = File(pickedFile.path);
            webImageBytes = null;
          });
        }
      }
    } catch (e) {
      showMessage("Error picking image: $e");
    }
  }
Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final formatted = formatDateAndAge(picked);
      if (formatted == null) {
        showMessage("You must be at least 16 years old");
        return;
      }
      if (!mounted) return;
      setState(() {
        dobController.text = formatted;
      });
    }
  }
  Future<void> _autofillLocation() async {
  final locationText = await AutofillController.autofillLocation();
  if (!mounted) return;

  if (locationText != null && locationText.isNotEmpty) {
    setState(() {
      locationController.text = locationText;
    });
  } else {
    showMessage("Failed to detect location. Please try again.");
  }
}
void showMessage(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(TextConstants.notice),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(TextConstants.ok),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final localeCountryCode = WidgetsBinding.instance.platformDispatcher.locale.countryCode;
    final countryMap = {'US': 'USA', 'IN': 'India', 'GB': 'UK'};
    selectedCountry = countryMap[localeCountryCode] ?? 'USA';
    }

  @override
  void dispose() {
    dobController.dispose();
    occupationController.dispose();
    otherQualificationController.dispose();
    addressController.dispose();
    locationController.dispose();
    referralCodeController.dispose();
    passwordController.dispose(); 
  confirmPasswordController.dispose(); 
    super.dispose();
    mobileController.dispose();
otpController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Form(
             key: _formKey,
   autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TextConstants.signup,
                    style: TextStyle(
                        color: Colorconstants.primaryblack,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                const SizedBox(height: 24),
                linear_indicator_with_text(steps: steps, currentStep: currentStep),
                const SizedBox(height: 24),
                const Text(TextConstants.createacc,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                

                Center(
                  child: ProfileImagePicker(
                    webImageBytes: webImageBytes,
                    fileImage: profileImage,
                    onPickImage: pickImage,
                  ),
                ),
                const SizedBox(height: 24),
            User_details_container(
  dobController: dobController,
  emailController: emailController, 
  selectedGender: selectedGender,
  onDateTap: () => selectDate(context),
  onGenderChanged: (value) {
    setState(() {
      selectedGender = value;
    });
  },
  mobileController: mobileController,
  otpController: otpController,
  onSendOtp: () {
    sendOtp();
  },
),


                const SizedBox(height: 20),
                const Text(TextConstants.locat, style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                TextFormField(
                  controller: locationController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Your current location",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Unavailable' : null,
                ),
              Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    TextButton(
      onPressed: _autofillLocation,
      child: const Text(
        'Re-detect',
        style: TextStyle(color: Colorconstants.primaryblue),
      ),
    ),
    const SizedBox(width: 8),
    ElevatedButton.icon(
      onPressed: _autofillLocation,
      icon: const Icon(Icons.my_location, size: 18),
      label: const Text("Detect Location"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colorconstants.primaryblue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 14),
      ),
    ),
  ],
),

                const SizedBox(height: 12),
                const Text(TextConstants.addres,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: "Street, Building, etc.",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    
                  ),
                  validator: (value) => value == null || value.trim().isEmpty ? 'Please enter your address' : null,
                  
                  
                ),
                
                
                
                
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const SizedBox(height: 20),
const Text(TextConstants.qualif, style: TextStyle(fontWeight: FontWeight.bold)),
const SizedBox(height: 8),
Stack(
  alignment: Alignment.centerRight,
  children: [
    TextFormField(
      controller: otherQualificationController,
      decoration: InputDecoration(
        labelText: 'Enter or select qualification',
        labelStyle: TextStyle(color: Colorconstants.primarygrey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      validator: (value) => value == null || value.trim().isEmpty
          ? 'Please enter qualification'
          : null,
    ),
    IconButton(
      icon: const Icon(Icons.arrow_drop_down),
      onPressed: () {
        setState(() {
          showQualificationDropdown = !showQualificationDropdown;
        });
      },
    ),
  ],
),
if (showQualificationDropdown)
  Container(
    margin: const EdgeInsets.only(top: 4),
    decoration: BoxDecoration(
      border: Border.all(color: Colorconstants.primarygrey),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: qualificationOptions.length,
      itemBuilder: (context, index) {
        final option = qualificationOptions[index];
        return ListTile(
          title: Text(option),
          onTap: () {
            setState(() {
              otherQualificationController.text = option;
              showQualificationDropdown = false;
            });
          },
        );
      },
    ),
  ),


               
              ],
            ),
            const SizedBox(height: 20),
                const Text(TextConstants.occupation, style: TextStyle(fontWeight: FontWeight.bold)),
          
                TextFormField(
  controller: occupationController,
  decoration: InputDecoration(
    labelText: 'Enter or select occupation',
    labelStyle: TextStyle(color: Colorconstants.primarygrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  ),
  validator: (value) => value == null || value.trim().isEmpty ? 'Please enter occupation' : null,
),
const SizedBox(height: 16),
                const Text(TextConstants.referal, style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                CustomTextField(
                  label: 'Enter referral code',
                  labelColor: Colorconstants.primarygrey,
                ),
                const SizedBox(height: 16),
const Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
const SizedBox(height: 6),
TextFormField(
  controller: passwordController,
  obscureText: true,
  decoration: InputDecoration(
    labelText: "Enter password",
    labelStyle: TextStyle(color: Colorconstants.primarygrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) return 'Please enter a password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  },
),

const SizedBox(height: 16),
const Text("Confirm Password", style: TextStyle(fontWeight: FontWeight.bold)),
const SizedBox(height: 6),
TextFormField(
  controller: confirmPasswordController,
  obscureText: true,
  decoration: InputDecoration(
    labelText: "Re-enter password",
    labelStyle: TextStyle(color: Colorconstants.primarygrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  },
),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: InkWell(
           onTap: () async {
  if (_formKey.currentState?.validate() ?? false) {
    if (selectedGender == null || selectedGender!.isEmpty) {
      showMessage("Please select your gender");
      return;
    }
    if (dobController.text.trim().isEmpty) {
      showMessage("Please select your date of birth");
      return;
    }

    if (verificationId == null) {
      showMessage("Please request an OTP first.");
      return;
    }

    if (otpController.text.trim().length != 6) {
      showMessage("Please enter a valid 6-digit OTP.");
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otpController.text.trim(),
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      showMessage("Invalid OTP. Please try again.");
      return;
    }

    // If OTP is valid, proceed to image upload and saving user data
    final imageUrl = await SignupController.uploadProfileImage(
      fileImage: profileImage,
      webImageBytes: webImageBytes,
    );

    final success = await SignupController.saveUserData(
      dob: dobController.text.trim(),
      email: emailController.text.trim(),
      gender: selectedGender!,
      location: locationController.text.trim(),
      address: addressController.text.trim(),
      qualification: otherQualificationController.text.trim(),
      occupation: occupationController.text.trim(),
      referralCode: referralCodeController.text.trim(),
      imageUrl: imageUrl,
      password: passwordController.text.trim(),
    );

    if (success) {
      showMessage("Signup data saved successfully!");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InterestsCategoriesWidget()),
      );
    } else {
      showMessage("Failed to save your data. Please try again.");
    }
  }
},

 child: CustomButton(
                      text: TextConstants.continu,
                      color: Colorconstants.primaryblue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
