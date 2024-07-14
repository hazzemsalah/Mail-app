import 'package:_11_mail_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConactViewFixedFotter extends StatelessWidget {
  const ConactViewFixedFotter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: kprimaryColor,
      ),
      child: Row(
        children: [
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              FontAwesomeIcons.inbox,
              size: 22,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
