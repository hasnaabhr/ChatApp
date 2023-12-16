import 'package:chat/constants.dart';
import 'package:chat/helper/ShowSnackBar.dart';
import 'package:chat/screens/ChatPage.dart';
import 'package:chat/screens/SignUpPage.dart';

import 'package:chat/widgets/CustomTextField.dart';
import 'package:chat/widgets/custombutton.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isloading = false;
  String? email, password;

  //work on form
  GlobalKey<FormState> formKye = GlobalKey();

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
              key: formKye,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/login.png',
                      width: 145,
                    ),
                  ),
                  const Row(
                    children: [
                      Text(
                        'Log in',
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
                      if (formKye.currentState!.validate()) {
                        isloading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          // ignore: use_build_context_synchronously
                          ShowSnackBar(context,
                              message: 'successfully registered',
                              color: Colors.green);

                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context, ChatPage.id,
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            // ignore: use_build_context_synchronously
                            ShowSnackBar(
                              context,
                              message: 'No user found for that email',
                              color: Colors.red,
                            );
                          } else if (e.code == 'wrong-password') {
                            // ignore: use_build_context_synchronously
                            ShowSnackBar(
                              context,
                              message: 'Wrong password provided for that user.',
                              color: Colors.red,
                            );
                          }
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          ShowSnackBar(
                            context,
                            message: 'There Was an Error',
                            color: Colors.red,
                          );
                        }
                        isloading = false;
                        setState(() {});
                      } else {}
                    },
                    title: 'Sign in',
                  ),
                  const SizedBox(
                    height: 20,
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
                          Navigator.pushNamed(context, SignUpPage.id);
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
