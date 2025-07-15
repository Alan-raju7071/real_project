import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/widgets/Custom_Textfield.dart';

class User_details_container extends StatelessWidget {
  final TextEditingController dobController;
   final TextEditingController emailController;
   final TextEditingController nameController;


  final String? selectedGender;
  final void Function()? onDateTap;
  final void Function(String?)? onGenderChanged;
  final TextEditingController mobileController;
  final TextEditingController otpController;
  final VoidCallback onSendOtp;

  const User_details_container({
    super.key,
    required this.dobController,
    required this.nameController,
     required this.emailController,
    required this.selectedGender,
    required this.mobileController,
    required this.otpController,
    this.onDateTap,
    this.onGenderChanged,
    required this.onSendOtp,
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
           const SizedBox(height: 16),
const Text("Full Name", style: TextStyle(fontWeight: FontWeight.bold)),
const SizedBox(height: 6),
TextFormField(
  controller: nameController,
  decoration: InputDecoration(
    labelText: "Enter your name",
    labelStyle: TextStyle(color: Colorconstants.primarygrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  ),
  validator: (value) =>
      value == null || value.trim().isEmpty ? 'Please enter your name' : null,
),

            const SizedBox(height: 10),

            const Text(TextConstants.email, style: TextStyle(fontWeight: FontWeight.bold)),
          
const SizedBox(height: 6),
TextFormField(
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(
    labelText: "Enter your email",
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  },
),

            const SizedBox(height: 16),

            const Text(TextConstants.mobilenumber, style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextFormField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Enter mobile number",
                prefixText: '+91 ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              validator: (value) {
                final fullNumber = "+91${value?.trim() ?? ''}";
                if (!RegExp(r'^\+91\d{10}$').hasMatch(fullNumber)) {
                  return 'Enter a valid 10-digit Indian mobile number';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Enter OTP",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    validator: (value) {
  final trimmed = value?.trim() ?? '';
  if (trimmed.isEmpty) return 'Please enter OTP';
  if (trimmed.length != 6) return 'OTP must be exactly 6 digits';
  return null;
},

                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onSendOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colorconstants.primaryblue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  child: const Text("Send OTP"),
                ),
              ],
            ),

            const SizedBox(height: 20),

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
                final regex = RegExp(r'\(Age: (\d+)\)');
                final match = regex.firstMatch(value);
                if (match != null) {
                  final age = int.parse(match.group(1)!);
                  if (age < 16) {
                    return 'You must be at least 16 years old';
                  }
                } else {
                  return 'Invalid date format';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            const Text(TextConstants.Gender, style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['Male', 'Female', 'Other'].map((gender) {
                return Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio<String>(
                        value: gender,
                        groupValue: selectedGender,
                        onChanged: onGenderChanged,
                        visualDensity: VisualDensity.compact,
                      ),
                      Flexible(
                        child: Text(
                          gender,
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
