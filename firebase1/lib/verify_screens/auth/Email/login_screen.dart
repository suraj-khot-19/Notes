import 'package:firebase1/Widget/utils/all_management.dart';
import 'package:firebase1/verify_screens/auth/Email/forgot_password.dart';
import 'package:firebase1/verify_screens/auth/Mobile/mobile_verify.dart';
import 'package:firebase1/verify_screens/auth/Email/sign_up.dart';
import 'package:firebase1/Widget/utils/utils.dart';
import 'package:firebase1/Widget/support_widget/button.dart';
import 'package:firebase1/Widget/support_widget/controllers.dart';
import 'package:firebase1/Widget/support_widget/sized_box.dart';
import 'package:firebase1/Widget/support_widget/text_feild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

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
            // builder: (context) => MyHome(),
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
        automaticallyImplyLeading: false,
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
                  // password logic

                  TextFormField(
                    obscureText: _obscureText,
                    controller: password,
                    decoration: InputDecoration(
                      suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      hintText: "password",
                      border: const OutlineInputBorder(gapPadding: 20.0),
                      labelText: "password",
                      focusColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    textAlign: TextAlign.left,
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
                        }
                      }),
                  addVerticalSpace(30),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      child: Text("Forgot Password"),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ForgotPasswordScreen();
                        }));
                      },
                    ),
                  ),
                  addVerticalSpace(5),
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
