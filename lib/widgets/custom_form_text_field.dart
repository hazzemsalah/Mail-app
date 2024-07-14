import 'package:flutter/material.dart';

class CustomFormTextFeild extends StatelessWidget {
  const CustomFormTextFeild({
    super.key,
    required this.hintText,
    this.onChange,
    this.scure = false,
    this.onSaved, this.controller,
  });
  final String hintText;
  final bool scure;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: TextFormField(
        controller: controller,
        onSaved: onSaved,
        obscureText: scure,
        validator: (data) {
          if (data!.isEmpty) {
            return "field is required";
          }
        },
        onChanged: onChange,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
