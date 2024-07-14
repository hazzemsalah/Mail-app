import 'package:_11_mail_app/helper/show_snack_bar.dart';
import 'package:_11_mail_app/widgets/custom_button.dart';
import 'package:_11_mail_app/widgets/custom_form_text_field.dart';
import 'package:_11_mail_app/widgets/custom_startup_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:_11_mail_app/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                const CustomStartupCard(
                  image: kSignUpImage,
                  title: "Create your account ",
                  subTitle:
                      "    It's about one step to join us!\n                 Register now",
                ),
                const SizedBox(height: 24),
                CustomFormTextFeild(
                  hintText: " E-mail",
                  onChange: (data) {
                    data.toLowerCase();
                    email = data;
                  },
                ),
                CustomFormTextFeild(
                  hintText: "Password",
                  scure: true,
                  onChange: (data) {
                    password = data;
                  },
                ),
                const SizedBox(height: 38),
                CustomButton(
                    text: "Sign Up",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await registerUser();
                          Navigator.pop(context);
                          showSnackBar(context, "Sign Up Success");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(
                                context, "The password provided is too weak.");
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context,
                                "The account already exists for that email.");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    }),
                const SizedBox(height: 52),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account ? ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
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

  Future<void> registerUser() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
