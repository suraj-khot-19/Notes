import 'package:firebase1/Widget/support_widget/button.dart';
import 'package:firebase1/Widget/support_widget/controllers.dart';
import 'package:firebase1/Widget/support_widget/text_feild.dart';
import 'package:firebase1/Widget/utils/utils.dart';
import 'package:firebase1/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Widget/support_widget/sized_box.dart';

class VerifyMobileUser extends StatefulWidget {
  final String verificationId;

  const VerifyMobileUser({super.key, required this.verificationId});

  @override
  State<VerifyMobileUser> createState() => _VerifyMobileUserState();
}

class _VerifyMobileUserState extends State<VerifyMobileUser> {
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child:
                  Text("Verify Mobile Number", style: TextStyle(fontSize: 15)),
            ),
            addVerticalSpace(50),
            textField(verifyCode, "enter 6 digit code", true, true, 1, 6),
            addVerticalSpace(30),
            Button(
                title: "Verify",
                loading: loading,
                onClick: () async {
                  setState(() {
                    loading = true;
                  });

                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId.toString(),
                      smsCode: verifyCode.text.toString());
                  try {
                    await _auth.signInWithCredential(credential);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const MyHome();
                    }));
                  } catch (e) {
                    Utils().toastMessage(e.toString());
                    setState(() {
                      loading = false;
                    });
                  }
                }),
          ],
        ),
      ),
    );
  }
}
