import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? suffix;
  final EdgeInsetsGeometry contentPadding;

  const CustomTextField({
    super.key,
    required this.label,
    this.labelColor,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.suffix,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: labelColor ?? Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: contentPadding,
        suffixIcon: suffix,
      ),
    );
  }
}
