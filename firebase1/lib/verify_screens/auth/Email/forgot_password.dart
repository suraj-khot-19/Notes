import 'package:firebase1/Widget/support_widget/button.dart';
import 'package:firebase1/Widget/support_widget/controllers.dart';
import 'package:firebase1/Widget/support_widget/text_feild.dart';
import 'package:firebase1/Widget/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Widget/support_widget/sized_box.dart';
import '../../../Widget/utils/all_management.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool loading = false;
  bool isMoulted = false;
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    isMoulted = true;
  }

  @override
  void dispose() {
    super.dispose();
    isMoulted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
                height: 35,
                width: 35,
                child: Image.asset(
                  'assets/images/app12.png',
                  fit: BoxFit.contain,
                )),
            addHorizontalSpace(90),
            Text(
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
            addHorizontalSpace(20),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            addVerticalSpace(50),
            Form(
              key: formKey,
              child: textField(
                  forgotPass, "Enter Your Registered Email", true, false, 1),
            ),
            addVerticalSpace(50),
            Button(
                loading: loading,
                title: "Verify",
                onClick: () {
                  setState(() {
                    loading = true;
                  });
                  if (formKey.currentState!.validate()) {
                    auth
                        .sendPasswordResetEmail(
                            email: forgotPass.text.toString())
                        .then((value) {
                      if (isMoulted) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage(
                            "Please Check Your Gmail Inbox Also Check Spam Folder!");
                        Navigator.pop(context);
                      }
                    }).onError((error, stackTrace) {
                      if (isMoulted) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage(error.toString());
                      }
                    });
                    setState(() {
                      forgotPass.clear();
                    });
                  }
                })
          ]),
        ),
      ),
    );
  }
}
