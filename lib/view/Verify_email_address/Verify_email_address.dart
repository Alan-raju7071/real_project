import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/view/Reset_password/Reset_Password.dart';
import 'package:real_project/widgets/Secondcustom_image_container.dart';
import 'package:real_project/widgets/custom_button.dart';

class VerifyEmailAddress extends StatefulWidget {
  const VerifyEmailAddress({super.key});

  @override
  State<VerifyEmailAddress> createState() => _VerifyEmailAddressState();
}

class _VerifyEmailAddressState extends State<VerifyEmailAddress> {
  final List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              TextConstants.verifyemail,
              style: TextStyle(
                color: Colorconstants.primaryblack,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            seconcustomimage_container(),
            const SizedBox(height: 20),
            Text(TextConstants.fourdigitl),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 60,
                      height: 60,
                      child: TextField(
                        controller: otpControllers[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24),
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Colorconstants.primarygrey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (otpControllers[0].text.isEmpty ||
                    otpControllers[1].text.isEmpty ||
                    otpControllers[2].text.isEmpty ||
                    otpControllers[3].text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please enter all 4 digits of the OTP')),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPassword(),
                    ),
                  );
                }
              },
              child: CustomButton(
                text: TextConstants.verifOTP,
                color: Colorconstants.primaryblue,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(TextConstants.dontrecived),
                  Text(
                    TextConstants.clickresend,
                    style: TextStyle(
                      color: Colorconstants.blueAccent,
                      decoration: TextDecoration.underline,
                      decorationColor: Colorconstants.blueAccent,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
