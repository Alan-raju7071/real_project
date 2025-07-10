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
  const SecondSignupScreen({super.key});

  @override
  State<SecondSignupScreen> createState() => _SecondSignupScreenState();
}

class _SecondSignupScreenState extends State<SecondSignupScreen> {
  final int currentStep = 1;
  final List<String> steps = ['Personal Info', 'Interests', 'Verify'];
  final TextEditingController dobController = TextEditingController();
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
      dobController.text = formatDateAndAge(picked); // ✅ Put here
    });
  }
}


  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Clear login state

    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
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
              const SizedBox(height: 70),
              User_details_container(
                dobController: dobController,
                selectedGender: selectedGender,
                onDateTap: () => _selectDate(context),
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
                child: Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.grey.shade100,
                  child: const Center(child: Text("Additional content goes here")),
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
