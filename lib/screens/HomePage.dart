import 'package:chat/constants.dart';
import 'package:chat/screens/LoginPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String id = 'HomePage';

  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(
              flex: 3,
            ),
            Image.asset(
              'assets/ratings.png',
              width: 200,
            ),
            const Spacer(
              flex: 2,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Text(
                'Welcome to our Chat App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Column(
              children: [
                Text(
                  'Chat instantly with all other',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Online users',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 6, 122, 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                  fixedSize: const Size(300, 60)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const LoginPage();
                  },
                ));
              },
              child: const Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
