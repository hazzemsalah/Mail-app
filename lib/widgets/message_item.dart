import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 30,
      minVerticalPadding: 10,
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
          child: Image.asset(image),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1, // Underline thickness
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios), // Right arrow icon
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
