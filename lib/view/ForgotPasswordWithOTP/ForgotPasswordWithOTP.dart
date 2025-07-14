import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordWithOTP extends StatefulWidget {
  const ForgotPasswordWithOTP({super.key});

  @override
  State<ForgotPasswordWithOTP> createState() => _ForgotPasswordWithOTPState();
}

class _ForgotPasswordWithOTPState extends State<ForgotPasswordWithOTP> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  String? verificationId;
  bool otpSent = false;
  bool otpVerified = false;
  bool loading = false;

  Future<void> sendOtp() async {
    final phone = '+91${mobileController.text.trim()}';
    setState(() => loading = true);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Optionally sign in automatically
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'OTP failed')));
        setState(() => loading = false);
      },
      codeSent: (String verId, int? resendToken) {
        setState(() {
          verificationId = verId;
          otpSent = true;
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("OTP Sent")));
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }

  Future<void> verifyOtp() async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otpController.text.trim(),
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() => otpVerified = true);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("OTP Verified")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid OTP")));
    }
  }

  Future<void> resetPassword() async {
    final user = FirebaseAuth.instance.currentUser;
    final newPassword = newPasswordController.text.trim();

    if (user != null && newPassword.length >= 6) {
      try {
        await user.updatePassword(newPassword);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password Updated")));
        Navigator.pop(context); 
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid new password")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password via OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!otpSent) ...[
              TextField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "Mobile Number"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: sendOtp,
                child: loading ? const CircularProgressIndicator() : const Text("Send OTP"),
              ),
            ] else if (!otpVerified) ...[
              TextField(
                controller: otpController,
                decoration: const InputDecoration(labelText: "Enter OTP"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: verifyOtp,
                child: const Text("Verify OTP"),
              ),
            ] else ...[
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "New Password"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: resetPassword,
                child: const Text("Reset Password"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
