import 'package:flutter/material.dart';

class CustomContactCard extends StatelessWidget {
  const CustomContactCard(
      {super.key,
      required this.contactImage,
      required this.title,
      required this.subTitle,
      required this.circularImage});
  final String contactImage;
  final String circularImage;
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
              // height: 200,
              child: Image.asset(contactImage),
            ),
            ListTile(
              horizontalTitleGap: 30,
              minTileHeight: 80,
              leading: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CircleAvatar(
                  child: Image.asset(circularImage),
                ),
              ),
              title: Text(
                title,
              ),
              subtitle: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: Text(
                    subTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
