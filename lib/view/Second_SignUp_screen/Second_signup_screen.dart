import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/view/login_screen/Login_screen.dart';
import 'package:real_project/widgets/User_details_container.dart';
import 'package:real_project/widgets/custom_button.dart';
import 'package:real_project/widgets/linear_indicator_with_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

String formatDateAndAge(DateTime date) {
  final now = DateTime.now();
  int age = now.year - date.year;
  if (now.month < date.month || (now.month == date.month && now.day < date.day)) {
    age--;
  }
  return "${DateFormat('dd/MM/yyyy').format(date)} (Age: $age)";
}

class SecondSignupScreen extends StatefulWidget {
  final String? selectedCountry;
  final String? selectedState;
  final String? city;
  final String? pincode;
  final String? qualification;
  final String? occupation;
  final String? referralCode;

  const SecondSignupScreen({
    super.key,
    this.selectedCountry,
    this.selectedState,
    this.city,
    this.pincode,
    this.qualification,
    this.occupation,
    this.referralCode,
  });

  @override
  State<SecondSignupScreen> createState() => _SecondSignupScreenState();
}

class _SecondSignupScreenState extends State<SecondSignupScreen> {
  final int currentStep = 1;
  final List<String> steps = ['Personal Info', 'Interests', 'Verify'];


  final TextEditingController dobController = TextEditingController();
final TextEditingController mobileController = TextEditingController();
final TextEditingController otpController = TextEditingController();
final TextEditingController emailController=TextEditingController();
String? selectedGender;

  

  Future<void> _selectDate(BuildContext context) async {
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

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
void dispose() {
  dobController.dispose();
  mobileController.dispose();
  otpController.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colorconstants.primarywhite,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                TextConstants.signup,
                style: TextStyle(
                  color: Colorconstants.primaryblack,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              linear_indicator_with_text(steps: steps, currentStep: currentStep),
              const SizedBox(height: 40),
             User_details_container(
              emailController: emailController, 
  dobController: dobController,
  selectedGender: selectedGender,
  onDateTap: () => _selectDate(context),

  onGenderChanged: (value) {
    setState(() {
      selectedGender = value;
    });
  },
  mobileController: mobileController,
  otpController: otpController,
  onSendOtp: () {
    
  },
),

              const SizedBox(height: 20),
              Material(
                elevation: 2,
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey.shade100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomButton(
                  text: TextConstants.continu,
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
