import 'package:_11_mail_app/constants.dart';
import 'package:_11_mail_app/helper/show_snack_bar.dart';
import 'package:_11_mail_app/widgets/custom_new_message_item.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class NewMessagePage extends StatefulWidget {
  const NewMessagePage({super.key});

  @override
  _NewMessagePageState createState() => _NewMessagePageState();
}

class _NewMessagePageState extends State<NewMessagePage> {
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
   bool isLoading = false;

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    _fromController.text = FirebaseAuth.instance.currentUser!.email ?? '';
  }

  void _sendMessage() async {
    String senderUid = FirebaseAuth.instance.currentUser!.uid;
    String receiverEmail = _toController.text.trim().toLowerCase();
    String subject = _subjectController.text.trim();
    String body = _bodyController.text.trim();
    String senderMail = _fromController.text.trim();

    if (receiverEmail.isEmpty || subject.isEmpty || body.isEmpty) {
      showSnackBar(context, "Please fill all fields");
      return;
    }

      setState(() {
      isLoading = true; 
    });

     bool isConnected = await _checkInternetConnection();

      setState(() {
      isLoading = false; 
    });
    if (!isConnected) {
      showSnackBar(context, "No internet connection. Please try again later.");
      return;
    }

    bool isValidRecipient = await _checkRecipientExists(receiverEmail);

    if (isValidRecipient) {
      try {
        DocumentReference docRef = await messages.add({
          'senderUid': senderUid,
          'senderMail': senderMail,
          'receiverEmail': receiverEmail,
          'subject': subject,
          'body': body,
          'timestamp': DateTime.now(),
        });

        // Update the document with the auto-generated ID (messageId)
        await docRef.update({
          'messageId': docRef.id,
        });

        _toController.clear();
        _subjectController.clear();
        _bodyController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email Sent')),
        );
      } catch (e) {
        print("Error sending message: $e");
        // Handle error as needed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send email')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('The email address is wrong or not registered')),
      );
    }
  }

  Future<bool> _checkInternetConnection() async {
    try {
      var response = await http.get(Uri.parse('https://www.google.com')).timeout(const Duration(seconds: 10));
      return response.statusCode == 200;
    } catch (e) {
      print('Error checking internet connection: $e');
      return false;
    }
  }

  Future<bool> _checkRecipientExists(String email) async {
    try {
      // Check if the email exists in the 'users' collection
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: email).get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking recipient: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 75,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                    ),
                  ],
                  color: kprimaryColor,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.xmark,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(flex: 2),
                    const Text(
                      "New message",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(flex: 24),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.solidPaperPlane,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _sendMessage();
                      },
                    ),
                  ],
                ),
              ),
              CustomNewMessageItem(
                text: "To :",
                hintText: "Recipient",
                hintcolor: Colors.grey,
                controller: _toController,
              ),
              const Divider(),
              CustomNewMessageItem(
                text: "From :",
                hintText: "Your Email",
                readOnly: true,
                hintcolor: Colors.grey,
                controller: _fromController,
              ),
              const Divider(),
              CustomNewMessageItem(
                text: "Subject :",
                hintText: "Subject",
                hintcolor: Colors.grey,
                controller: _subjectController,
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _bodyController,
                  maxLines: 15,
                  decoration: const InputDecoration(
                    hintText: 'Enter your text here...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
