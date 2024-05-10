import 'package:firebase1/Widget/utils/all_management.dart';
import 'package:firebase1/verify_screens/auth/Mobile/mobile_verify.dart';
import 'package:firebase1/verify_screens/auth/Email/sign_up.dart';
import 'package:firebase1/Widget/utils/utils.dart';
import 'package:firebase1/screens/home.dart';
import 'package:firebase1/Widget/support_widget/button.dart';
import 'package:firebase1/Widget/support_widget/controllers.dart';
import 'package:firebase1/Widget/support_widget/sized_box.dart';
import 'package:firebase1/Widget/support_widget/text_feild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  void loginForUser() {
    _auth
        .signInWithEmailAndPassword(
            email: username.text.toString(), password: password.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      setState(() {
        loading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHome(),
          ));
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringManger().appName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.pink.withOpacity(0.8),
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  addVerticalSpace(10),
                  SizedBox(height: 60, width: 60, child: IconManager().appLogo),
                  addVerticalSpace(50),
                  emailTextFeild(username, "Email", true, false, 1),
                  addVerticalSpace(20),
                  textField(
                    password,
                    "Password",
                    true,
                    true,
                    1,
                  ),
                  addVerticalSpace(60),
                  Button(
                      loading: loading,
                      title: "Login",
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });

                          loginForUser();
                          setState(() {
                            username.clear();
                            password.clear();
                          });
                        }
                      }),
                  addVerticalSpace(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(("Don't have an account?")),
                      addHorizontalSpace(2),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ));
                        },
                        child: const Text(("Sign Up")),
                      )
                    ],
                  ),
                  addVerticalSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(("Login Using Mobile Number?")),
                      addHorizontalSpace(2),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MobileVerify(),
                              ));
                        },
                        child: const Text(("Login")),
                      )
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
}
