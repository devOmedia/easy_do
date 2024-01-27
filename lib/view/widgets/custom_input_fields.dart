import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.controller,
    required this.hint,
    this.inputAction = TextInputAction.next,
    this.inputType = TextInputType.text,
    required this.validator,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: inputAction,
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        // border: InputBorder.none,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade100, width: 0.0),
          borderRadius: BorderRadius.circular(14),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey.shade300,
        ),
      ),
      validator: validator,
    );
  }
}
