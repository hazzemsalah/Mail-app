import 'package:flutter/material.dart';

class BodyDetailsItem extends StatelessWidget {
  const BodyDetailsItem(
      {super.key, required this.text, required this.hintText});
  final String text;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 8),
      child: Column(
        children: [
          Row(children: [
            Text(text, style: const TextStyle(color: Colors.grey, fontSize: 18))
          ]),
          TextField(
            maxLines: 15,
            readOnly: true,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
