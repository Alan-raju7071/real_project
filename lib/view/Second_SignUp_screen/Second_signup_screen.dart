import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/widgets/User_details_container.dart';
import 'package:real_project/widgets/custom_button.dart';
import 'package:real_project/widgets/linear_indicator_with_text.dart';

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
        dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.red),
          onPressed: () {
            
            
            Navigator.popUntil(context, (route) => route.isFirst); 
          },
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
          
                   User_details_container(dobController: dobController,
  selectedGender: selectedGender,
  onDateTap: () => _selectDate(context),
  onGenderChanged: (value) {
    setState(() {
      selectedGender = value;
    });
  },),
                   SizedBox(height: 20,),
                   Material(
                    elevation: 2,
                    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                     child: Container(
                      width: double.infinity,
                      height: 100,
                      
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(vertical: 20),
                     child: CustomButton(text: TextConstants.continu, color: Colorconstants.primaryblue),
                   )
            ],
          ),
        ),
      ),
    );
  }
}