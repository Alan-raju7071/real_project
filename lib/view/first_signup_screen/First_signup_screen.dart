import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/view/Second_SignUp_screen/Second_signup_screen.dart';
import 'package:real_project/widgets/Custom_Textfield.dart';
import 'package:real_project/widgets/User_details_container.dart';
import 'package:real_project/widgets/custom_button.dart';
import 'package:real_project/widgets/linear_indicator_with_text.dart';
import 'package:file_picker/file_picker.dart';
String formatDateAndAge(DateTime date) {
  final now = DateTime.now();
  int age = now.year - date.year;
  if (now.month < date.month || (now.month == date.month && now.day < date.day)) {
    age--;
  }
  return "${DateFormat('dd/MM/yyyy').format(date)} (Age: $age)";
}

class FirstSignupScreen extends StatefulWidget {
  const FirstSignupScreen({super.key});

  @override
  State<FirstSignupScreen> createState() => FirstSignupScreenState();
}

class FirstSignupScreenState extends State<FirstSignupScreen> {
  final int currentStep = 0;
  final List<String> steps = ['Personal Info', 'Interests', 'Verify'];

  final TextEditingController dobController = TextEditingController();
  String? selectedGender;
  File? profileImage;
  Uint8List? webImageBytes;

  Future<void> pickImage() async {
    try {
      if (kIsWeb) {
        final result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result != null && result.files.single.bytes != null) {
          setState(() {
            webImageBytes = result.files.single.bytes!;
            profileImage = null;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile image updated")),
          );
        }
      } else {
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            profileImage = File(pickedFile.path);
            webImageBytes = null;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile image updated")),
          );
        }
      }
    } catch (e) {
      print("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to pick image")),
      );
    }
  }

  Future<void> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime(2000),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  if (picked != null) {
    setState(() {
      dobController.text = formatDateAndAge(picked);
    });
  }
}


  @override
  void dispose() {
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TextConstants.signup,
                style: TextStyle(
                  color: Colorconstants.primaryblack,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 24),
              linear_indicator_with_text(steps: steps, currentStep: currentStep),
              const SizedBox(height: 24),
              const Text(
                TextConstants.createacc,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: webImageBytes != null
                          ? MemoryImage(webImageBytes!)
                          : profileImage != null
                              ? FileImage(profileImage!)
                              : null,
                      child: (webImageBytes == null && profileImage == null)
                          ? const Icon(Icons.person, size: 50, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.edit, size: 16, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              User_details_container(
                dobController: dobController,
                selectedGender: selectedGender,
                onDateTap: () => selectDate(context),
                onGenderChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              Material(
                elevation: 2,
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(TextConstants.country, style: TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Country',
                                    labelStyle: TextStyle(color: Colorconstants.primarygrey),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                  ),
                                  items: ['India', 'USA', 'UK'].map((country) {
                                    return DropdownMenuItem(value: country, child: Text(country));
                                  }).toList(),
                                  onChanged: (value) {},
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(TextConstants.state, style: TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'State',
                                    labelStyle: TextStyle(color: Colorconstants.primarygrey),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                  ),
                                  items: ['Kerala', 'Maharashtra', 'Delhi'].map((state) {
                                    return DropdownMenuItem(value: state, child: Text(state));
                                  }).toList(),
                                  onChanged: (value) {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(TextConstants.city, style: TextStyle(fontWeight: FontWeight.bold)),
                                CustomTextField(label: "City", labelColor: Colorconstants.primarygrey),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(TextConstants.pincod, style: TextStyle(fontWeight: FontWeight.bold)),
                                CustomTextField(label: "Pin Code", labelColor: Colorconstants.primarygrey),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Material(
                elevation: 2,
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Qualification', style: TextStyle(fontWeight: FontWeight.bold)),
                      CustomTextField(label: 'Select Qualification', labelColor: Colorconstants.primarygrey),
                      const SizedBox(height: 16),
                      const Text('Occupation', style: TextStyle(fontWeight: FontWeight.bold)),
                      CustomTextField(label: 'Select occupation', labelColor: Colorconstants.primarygrey),
                      const SizedBox(height: 16),
                      const Text('Referral Code (Optional)', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      CustomTextField(label: 'Enter referral code', labelColor: Colorconstants.primarygrey),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SecondSignupScreen(),));
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
    );
  }
}
