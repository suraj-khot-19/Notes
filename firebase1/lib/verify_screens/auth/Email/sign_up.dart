import 'package:firebase1/Widget/utils/all_management.dart';
import 'package:firebase1/verify_screens/auth/Email/login_screen.dart';
import 'package:firebase1/Widget/support_widget/button.dart';
import 'package:firebase1/Widget/support_widget/controllers.dart';
import 'package:firebase1/Widget/support_widget/sized_box.dart';
import 'package:firebase1/Widget/support_widget/text_feild.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";

import '../../../Widget/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fullName.dispose();
    username.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

//password check
  bool checkPass() {
    if (password.text.toString() != confirmPassword.text.toString()) {
      Utils().toastMessage("password not match!");
      setState(() {
        loading = false;
      });
      return false;
    } else {
      return true;
    }
  }

//firebase authentication
  void loginErrorHandling() {
    if (checkPass()) {
      _auth
          .createUserWithEmailAndPassword(
              email: username.text.toString(),
              password: password.text.toString())
          .then((value) {
        setState(() {
          loading = false;
        });

        Utils().toastMessage("Now You Login With Your Creditials");
        // Navigate to login screen after successful registration
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
        setState(() {
          loading = false;
        });
      });
    }
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
            child: Column(
              children: [
                addVerticalSpace(5),
                SizedBox(height: 60, width: 60, child: IconManager().appLogo),
                addVerticalSpace(5),
                const Center(
                  child: Text("Create your account",
                      style: TextStyle(fontSize: 25)),
                ),
                addVerticalSpace(18),
                textField(
                  fullName,
                  "Full Name",
                  true,
                  false,
                  1,
                ),
                addVerticalSpace(18),
                emailTextFeild(username, "Email", true, false, 1),
                addVerticalSpace(18),
                textField(
                  password,
                  "Password",
                  true,
                  true,
                  1,
                ),
                addVerticalSpace(18),
                textField(
                  confirmPassword,
                  "Confirm Password",
                  true,
                  true,
                  1,
                ),
                addVerticalSpace(20),
                Button(
                    title: "Sign Up",
                    loading: loading,
                    onClick: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        loginErrorHandling();
                      }
                      setState(() {
                        username.clear();
                        fullName.clear();
                        password.clear();
                        confirmPassword.clear();
                      });
                    }),
                addVerticalSpace(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(("Already have an account?")),
                    addHorizontalSpace(2),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                      },
                      child: const Text(("Login")),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
