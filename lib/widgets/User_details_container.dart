import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/widgets/Custom_Textfield.dart';

class User_details_container extends StatelessWidget {
  final TextEditingController dobController;
  final String? selectedGender;
  final void Function()? onDateTap;
  final void Function(String?)? onGenderChanged;

  const User_details_container({
    super.key,
    required this.dobController,
    required this.selectedGender,
    this.onDateTap,
    this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(TextConstants.username, style: TextStyle(fontWeight: FontWeight.bold)),
            CustomTextField(
              label: "Enter your username",
              labelColor: Colorconstants.primarygrey,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            const Text(TextConstants.email, style: TextStyle(fontWeight: FontWeight.bold)),
            CustomTextField(
              label: "Enter your email address",
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
            const Text(TextConstants.mobilenumber, style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CustomTextField(
                    label: "Enter your mobile number",
                    labelColor: Colorconstants.primarygrey,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return 'Enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    alignment: Alignment.center,
                    child: Text(
                      TextConstants.sendOTP,
                      style: TextStyle(
                        color: Colorconstants.primaryblack,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(TextConstants.datebirth, style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextFormField(
              controller: dobController,
              readOnly: true,
              onTap: onDateTap,
              decoration: InputDecoration(
                labelText: 'Pick a Date',
                labelStyle: TextStyle(color: Colorconstants.primarygrey),
                suffixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select your date of birth';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            const Text(TextConstants.Gender, style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: InputDecoration(
                labelText: 'Select Gender',
                labelStyle: TextStyle(color: Colorconstants.primarygrey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: ['Male', 'Female', 'Other'].map((gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: onGenderChanged,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please select a gender' : null,
            ),
          ],
        ),
      ),
    );
  }
}
