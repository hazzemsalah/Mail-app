import 'package:_11_mail_app/constants.dart';
import 'package:_11_mail_app/models/message_model.dart';
import 'package:_11_mail_app/widgets/body_details_item.dart';
import 'package:_11_mail_app/widgets/custom_new_message_item.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MessageModel message =
        ModalRoute.of(context)!.settings.arguments as MessageModel;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
        toolbarHeight: 50,
        backgroundColor: kprimaryColor,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text(
            'Message Details',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNewMessageItem(
              text: "From :",
              hintText: message.senderMail,
              readOnly: true,
              hintcolor: Colors.black,
            ),
            const Divider(),
            CustomNewMessageItem(
              text: "To :",
              hintText: message.receiverEmail,
              readOnly: true,
              hintcolor: Colors.black,
            ),
            const Divider(),
            CustomNewMessageItem(
              text: "Subject :",
              hintText: message.subject,
              readOnly: true,
              hintcolor: Colors.black,
            ),
            const Divider(),
            BodyDetailsItem(text: "Body :", hintText: message.body),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("${message.timestamp}")],
              ),
            )
          ],
        ),
      ),
    );
  }
}
