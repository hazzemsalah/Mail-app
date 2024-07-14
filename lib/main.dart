import 'package:_11_mail_app/firebase_options.dart';
import 'package:_11_mail_app/views/inbox_page.dart';
import 'package:_11_mail_app/views/login_page.dart';
import 'package:_11_mail_app/views/message_page.dart';
import 'package:_11_mail_app/views/new_message_page.dart';
import 'package:_11_mail_app/views/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MailApp());
}

class MailApp extends StatelessWidget {
  const MailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "LoginPage": (context) => const LoginPage(),
        "SignUpPage": (context) => const SignUpPage(),
        "InBoxPage": (context) => const InBoxPage(),
        "NewMessagePage": (context) => const NewMessagePage(),
        "MessagePage": (context) => const MessagePage(),
      },
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            final User? user = snapshot.data;
            return user != null ? const InBoxPage() : const LoginPage();
          }
        },
      ),
    );
  }
}
