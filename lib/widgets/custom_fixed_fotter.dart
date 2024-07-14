import 'package:_11_mail_app/constants.dart';
import 'package:_11_mail_app/views/contacts_page.dart';
import 'package:flutter/material.dart';

class CustomFixedFotter extends StatelessWidget {
  const CustomFixedFotter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: kprimaryColor,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ContactsPage();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.perm_contact_cal,
              size: 28,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
