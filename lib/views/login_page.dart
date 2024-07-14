import 'package:_11_mail_app/constants.dart';
import 'package:_11_mail_app/helper/show_snack_bar.dart';
import 'package:_11_mail_app/widgets/custom_button.dart';
import 'package:_11_mail_app/widgets/custom_form_text_field.dart';
import 'package:_11_mail_app/widgets/custom_startup_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                const CustomStartupCard(
                  image: kSingInImage,
                  title: "Sign In",
                  subTitle: "Please type your\nE-mail & Password",
                ),
                const SizedBox(height: 24),
                CustomFormTextFeild(
                  controller: emailController,
                  hintText: "E-mail",
                  onChange: (data) {
                    data.toLowerCase();
                    email = data;
                  },
                ),
                CustomFormTextFeild(
                  controller: passwordController,
                  hintText: "Password",
                  scure: true,
                  onChange: (data) {
                    password = data;
                  },
                ),
                const SizedBox(height: 38),
                CustomButton(
                  text: "Log in",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        await loginUser();
                        Navigator.pushNamed(context, "InBoxPage",
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, "No user found for that email");
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(
                              context, "Wrong password provided for that user");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                ),
                const SizedBox(height: 52),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Still without an account? ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "SignUpPage");
                        emailController.clear();
                        passwordController.clear();
                      },
                      child: const Text(
                        "Create one",
                        style: TextStyle(
                          color: kprimaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    try {
      email = emailController.text.trim();
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      await storeEmail(email!);

      emailController.clear();
      passwordController.clear();
    } catch (e) {
      print("Error logging in: $e");
      throw e;
    }
  }

  Future<void> storeEmail(String email) async {
    try {
      await users.doc(email).set({
        "email": email,
        "uid": FirebaseAuth.instance.currentUser?.uid,
      });
      print("User added to Firestore");
    } catch (e) {
      print("Error adding user: $e");
      throw e;
    }
  }
}
