import 'package:_11_mail_app/widgets/custom_app_bar.dart';
import 'package:_11_mail_app/widgets/custom_fixed_fotter.dart';
import 'package:_11_mail_app/widgets/message_item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InBoxPage extends StatelessWidget {
  const InBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: const Color(0xFF55EBD6),
        onPressed: () {
          Navigator.pushNamed(context, "NewMessagePage");
        },
        child: const Icon(
          FontAwesomeIcons.penFancy,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          CustomAppBar(
            firstIcon: FontAwesomeIcons.arrowRightFromBracket,
            onPressed: () {
              _signOut(context); 
            },
            title: 'Inbox',
            secondIcon: FontAwesomeIcons.magnifyingGlass,
            thirdIcon: FontAwesomeIcons.ellipsisVertical,
          ),
          const Expanded(child: MessageItemListView()),
          const CustomFixedFotter()
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, "LoginPage", (route) => false); 
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}