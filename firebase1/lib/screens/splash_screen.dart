import 'package:firebase1/firebase_services/splash_service.dart';
import 'package:flutter/cupertino.dart';
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
    return const Scaffold(
      body: Center(
          child: SizedBox(
              height: 200,
              width: 200,
              child: Column(
                children: [
                  CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 5,
                  ),
                  Text(
                    "Loadding ...",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ))),
    );
  }
}
