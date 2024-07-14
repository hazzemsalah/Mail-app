import 'package:flutter/material.dart';

class CustomNewMessageItem extends StatelessWidget {
  const CustomNewMessageItem(
      {super.key,
      required this.text,
      required this.hintText,
      this.controller,
      this.readOnly = false,
      required this.hintcolor,
      this.onSaved});
  final String text;
  final String hintText;
  final TextEditingController? controller;
  final bool readOnly;
  final Color hintcolor;
  final void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 49,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 8),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TextFormField(
              onSaved: onSaved,
              maxLines: 2,
              readOnly: readOnly,
              controller: controller,
              validator: (data) {
                if (data!.isEmpty) {
                  return "field is required";
                }
              },
              onChanged: (data) {},
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: hintcolor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
