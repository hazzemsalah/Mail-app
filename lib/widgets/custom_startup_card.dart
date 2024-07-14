import 'package:flutter/material.dart';

class CustomStartupCard extends StatelessWidget {
  const CustomStartupCard(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle});
  final String image;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Card(
        elevation: 0,
        shadowColor: Colors.white,
        color: const Color(0xFFFFFFFF),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Image.asset(image),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
              ),
            ),
            Text(
              subTitle,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
