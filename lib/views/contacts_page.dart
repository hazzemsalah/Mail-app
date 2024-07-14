import 'package:_11_mail_app/widgets/contact_card_list_view.dart';
import 'package:_11_mail_app/widgets/contact_view_fixed_fotter.dart';
import 'package:_11_mail_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            firstIcon: FontAwesomeIcons.bars,
            title: 'Contacts',
            secondIcon: FontAwesomeIcons.magnifyingGlass,
            thirdIcon: FontAwesomeIcons.ellipsisVertical,
          ),
          Expanded(child: ContactCardListView()),
          ConactViewFixedFotter()
        ],
      ),
    );
  }
}
