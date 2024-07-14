import 'package:_11_mail_app/constants.dart';
import 'package:_11_mail_app/widgets/custom_contact_card.dart';
import 'package:flutter/material.dart';

class ContactCardListView extends StatelessWidget {
  const ContactCardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return const CustomContactCard(
          contactImage: kContactImage,
          circularImage: kMessageImage,
          title: "contact name",
          subTitle: "type of contact",
        );
      },
    );
  }
}
