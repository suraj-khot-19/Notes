import 'package:firebase1/Widget/auth/login_screen.dart';
import 'package:firebase1/Widget/support_widget/button.dart';
import 'package:firebase1/Widget/support_widget/controllers.dart';
import 'package:firebase1/Widget/support_widget/sized_box.dart';
import 'package:firebase1/Widget/support_widget/text_feild.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";

import '../utils/utils.dart';

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
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  //firebase authentication
  void loginErrorHandling() {
    _auth
        .createUserWithEmailAndPassword(
            email: username.text.toString(), password: password.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
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
        title: const Text("Sign Up Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text("Create Account", style: TextStyle(fontSize: 30)),
              ),
              addVerticalSpace(50),
              textField(username, "Username", true, false),
              textField(password, "Password", true, true),
              addVerticalSpace(60),
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
                  }),
              addVerticalSpace(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(("Already have an account?")),
                  addHorizontalSpace(30),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    },
                    child: const Text(("Login")),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
