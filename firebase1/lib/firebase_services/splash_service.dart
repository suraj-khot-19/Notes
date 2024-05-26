import 'dart:async';
import 'package:firebase1/verify_screens/auth/Email/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';

final _auth = FirebaseAuth.instance;
final user = _auth.currentUser;

class SplashService {
  void isLogin(BuildContext context) {
    if (user != null) {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => const MyHome(),
            builder: (context) => const MyHome(),
          ),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        ),
      );
    }
  }
}
