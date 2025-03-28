import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/pages/intro_page.dart';
import 'package:new_project/screens/sign_up_screen.dart';
import 'package:new_project/splash_screen/splash_screen.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  bool _startSplash = true;

  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  void _startSplashScreen() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      _startSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_startSplash) {
      return const SplashScreen();
    }
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const IntroPage();
        } else {
          return const SignUpPage();
        }
      },
    );
  }
}
