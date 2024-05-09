import 'dart:async';
import 'package:firebase1/screens/home.dart';
import 'package:firebase1/verify_screens/auth/Email/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _auth = FirebaseAuth.instance;
final user = _auth.currentUser;

class SplashService {
  void isLogin(BuildContext context) {
    if (user != null) {
      Timer(
        const Duration(seconds: 4),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHome(),
          ),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 4),
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
