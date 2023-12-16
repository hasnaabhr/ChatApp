import 'package:chat/firebase_options.dart';
import 'package:chat/screens/ChatPage.dart';
import 'package:chat/screens/HomePage.dart';
import 'package:chat/screens/LoginPage.dart';

import 'package:chat/screens/SignUpPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomePage.id: (context) => const HomePage(),
        SignUpPage.id: (context) => const SignUpPage(),
        ChatPage.id: (context) => const ChatPage(),
        LoginPage.id: (context) => const LoginPage(),
        ChatPage.id: (context) => const ChatPage(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.id,
    );
  }
}
