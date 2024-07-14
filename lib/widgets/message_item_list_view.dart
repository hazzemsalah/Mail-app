import 'package:_11_mail_app/constants.dart';
import 'package:_11_mail_app/models/message_model.dart';
import 'package:_11_mail_app/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageItemListView extends StatelessWidget {
  const MessageItemListView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserEmail = FirebaseAuth.instance.currentUser!.email;
    final messagesRef = FirebaseFirestore.instance.collection('messages');

    return StreamBuilder<QuerySnapshot>(
      stream: messagesRef
          .where('receiverEmail', isEqualTo: currentUserEmail)
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final List<DocumentSnapshot> documents = snapshot.data!.docs;

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final message = MessageModel.fromSnapshot(
              documents[index].data() as Map<String, dynamic>,
            );

            return Dismissible(
              key: Key(message.messageId),
              direction: DismissDirection.startToEnd,
              background: Container(
                alignment: AlignmentDirectional.centerStart,
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              onDismissed: (direction) {
                _deleteMessage(context, message);
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "MessagePage",
                      arguments: message);
                },
                child: MessageItem(
                  title: message.subject,
                  subtitle: message.body,
                  image: kMessageImage,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _deleteMessage(BuildContext context, MessageModel message) async {
    try {
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(message.messageId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message deleted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete message')),
      );
      print('Error deleting message: $e');
    }
  }
}
