import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/widgets/Custom_Textfield.dart';
import 'package:real_project/widgets/User_details_container.dart';
import 'package:real_project/widgets/custom_button.dart';
import 'package:real_project/widgets/linear_indicator_with_text.dart';

class FirstSignupScreen extends StatefulWidget {
  const FirstSignupScreen({super.key});

  @override
  State<FirstSignupScreen> createState() => _FirstSignupScreenState();
}

class _FirstSignupScreenState extends State<FirstSignupScreen> {
  final int currentStep = 0;
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
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
                  User_details_container(dobController: dobController,
  selectedGender: selectedGender,
  onDateTap: () => _selectDate(context),
  onGenderChanged: (value) {
    setState(() {
      selectedGender = value;
    });
  },),
              const SizedBox(height: 20),
              Material(
                elevation: 2,
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                child: Container(
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
                        labelStyle: TextStyle(color: Colorconstants.primarygrey,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      ),
                      items: ['India', 'USA', 'UK'].map((country) {
                        return DropdownMenuItem(
                          value: country,
                          child: Text(country),
                        );
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
                        labelStyle: TextStyle(color: Colorconstants.primarygrey,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      ),
                      items: ['Kerala', 'Maharashtra', 'Delhi'].map((state) {
                        return DropdownMenuItem(
                          value: state,
                          child: Text(state),
                        );
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
                     CustomTextField(label: "City",
                    labelColor: Colorconstants.primarygrey,
                   
                   )
                    
                  ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(TextConstants.pincod, style: TextStyle(fontWeight: FontWeight.bold)),
                    
                   CustomTextField(label: "Pin Code",
                    labelColor: Colorconstants.primarygrey,
                   
                   )
                  ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Material(
                elevation: 2,
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(12),
                    ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('Qualification', style: TextStyle(fontWeight: FontWeight.bold)),
                      CustomTextField(label: 'Select Qualification',
                       labelColor: Colorconstants.primarygrey,
                     ),
                  SizedBox(height: 16),
                  Text('Occupation', style: TextStyle(fontWeight: FontWeight.bold)),
                      CustomTextField(label: 'Select occupation',
                       labelColor: Colorconstants.primarygrey,
                        ),
                    const SizedBox(height: 16),
                        const Text(
                        'Referral Code (Optional)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      CustomTextField(label: 'Enter referral code',
                       labelColor: Colorconstants.primarygrey,

                      ),
                     
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomButton(text: TextConstants.continu, color:  Colorconstants.primaryblue),
              )


 ],
          ),
        ),
      ),
    );
  }
}

