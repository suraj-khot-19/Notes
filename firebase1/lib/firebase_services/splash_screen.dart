import 'package:firebase1/Widget/support_widget/sized_box.dart';
import 'package:firebase1/firebase_services/splash_service.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashService = SplashService();
  @override
  void initState() {
    super.initState();
    splashService.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: const CircularProgressIndicator(
              color: Colors.cyan,
              strokeWidth: 3,
            ),
          ),
          addVerticalSpace(30),
          const Text(
            "Loading...",
            style: TextStyle(
              fontSize: 20,
              color: Colors.cyan,
            ),
          ),
        ],
      )),
    );
  }
}
