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
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

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
                emailTextFeild(username, "Email", true, false, 1),
                addVerticalSpace(18),
                //password logic
                TextFormField(
                  obscureText: _obscureText,
                  controller: password,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_sharp
                            : Icons.visibility_sharp,
                      ),
                      onPressed: _toggleObscured,
                    ),
                    hintText: "password",
                    border: const OutlineInputBorder(gapPadding: 20.0),
                    labelText: "password",
                    focusColor: Colors.white,
                  ),
                  validator: _validatePassword,
                  textAlign: TextAlign.left,
                ),
                addVerticalSpace(18),
//confirm password
                TextFormField(
                  controller: confirmPassword,
                  obscureText: _obscureText2,
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                    border: const OutlineInputBorder(gapPadding: 20.0),
                    labelText: "Confirm password",
                    focusColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText2
                            ? Icons.visibility_off_sharp
                            : Icons.visibility_sharp,
                      ),
                      onPressed: _toggleConfirmObscured,
                    ),
                  ),
                  validator: _validateConfirmPassword,
                  textAlign: TextAlign.left,
                ),
                addVerticalSpace(30),
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

//pass btn
  void _toggleObscured() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

//confirm pass btn
  void _toggleConfirmObscured() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

//password conditins
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    if (RegExp(r'\s').hasMatch(value)) {
      return 'Password must not contain spaces';
    }
    return null;
  }

//confirm pass
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password.text) {
      return 'Passwords do not match';
    }
    return null;
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
