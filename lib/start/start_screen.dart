import 'package:flutter/material.dart';
import '../register/login_screen.dart';
import '../register/register.dart';

class Startscreen extends StatelessWidget {
  static const String routeName = '/Startscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/Content.png"),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(263, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(56),
                ),
                backgroundColor: const Color(0xff1A766E),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, Loginscreen.routeName);
              },
              child: const Text("Login", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(263, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(56),
                ),
                backgroundColor: Colors.white,
                shadowColor: const Color(0xff1A766E),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, register.routeName);
              },
              child: const Text("Sign Up",
                  style: TextStyle(color: Color(0xff1A766E))),
            ),
          ],
        ),
      ),
    );
  }
}
