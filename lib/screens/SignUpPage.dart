import 'package:chat/constants.dart';
import 'package:chat/helper/ShowSnackBar.dart';
import 'package:chat/screens/ChatPage.dart';

import 'package:chat/widgets/CustomButton.dart';
import 'package:chat/widgets/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static String id = 'SignUpPage';
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? email;

  String? password;

  bool isloading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: isloading,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/signup.png',
                        width: 145,
                      ),
                    ),
                    const Row(
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 32,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // const CustomTextfield(
                    //   hintText: 'Enter your Name',
                    // ),

                    // const SizedBox(
                    //   height: 20,
                    // ),
                    CustomFormTextfield(
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: 'Enter your e-mail',
                      icon: const Icon(Icons.email),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormTextfield(
                      obscureText: true,
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: 'Enter your password',
                      icon: const Icon(Icons.password),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isloading = true;
                          setState(() {});
                          try {
                            await RegisterUser();
                            // ignore: use_build_context_synchronously
                            ShowSnackBar(context,
                                message: 'successfully registered',
                                color: Colors.green);
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(context, ChatPage.id,
                                arguments: email);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              // ignore: use_build_context_synchronously
                              ShowSnackBar(context,
                                  message: 'weak-password', color: Colors.red);
                            } else if (e.code == 'email-already-in-use') {
                              // ignore: use_build_context_synchronously
                              ShowSnackBar(context,
                                  message: 'email-already-in-use',
                                  color: Colors.red);
                            }
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            ShowSnackBar(context,
                                message: 'There Was an Error',
                                color: Colors.red);
                          }
                          isloading = false;
                          setState(() {});
                        } else {}
                      },
                      title: 'Sign Up',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have account?",
                          style: TextStyle(
                            fontSize: 16,
                            color: kPrimaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            '  Sign Up',
                            style: TextStyle(
                                fontSize: 16,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),

                    // Spacer(flex: 3,),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Future<void> RegisterUser() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
