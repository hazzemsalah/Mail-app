import 'package:_11_mail_app/constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.firstIcon,
    required this.title,
    required this.secondIcon,
    required this.thirdIcon,
    this.onPressed,
  });
  final IconData firstIcon;
  final String title;
  final IconData secondIcon;
  final IconData thirdIcon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 4,
        ),
      ], color: kprimaryColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const Spacer(),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              firstIcon,
              color: Colors.white,
              size: 22,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(flex: 40),
        ],
      ),
    );
  }
}
