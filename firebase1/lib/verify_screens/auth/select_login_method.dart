import 'package:firebase1/verify_screens/auth/login_screen.dart';
import 'package:firebase1/verify_screens/auth/mobile_verify.dart';
import 'package:firebase1/verify_screens/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Widget/support_widget/button.dart';
import '../../Widget/support_widget/sized_box.dart';

class SelectLoginMethod extends StatefulWidget {
  const SelectLoginMethod({super.key});

  @override
  State<SelectLoginMethod> createState() => _SelectLoginMethodState();
}

class _SelectLoginMethodState extends State<SelectLoginMethod> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Login "),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child:
                    Text("Select Login Method", style: TextStyle(fontSize: 25)),
              ),
              addVerticalSpace(50),
              //email
              Button(
                  icon: Icons.email,
                  title: "Email",
                  onClick: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  }),
              addVerticalSpace(30),

              //mobile
              Button(
                  icon: Icons.send_to_mobile_outlined,
                  title: "Mobile Number",
                  onClick: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const MobileVerify();
                    }));
                  }),
              addVerticalSpace(30),
              //google
              Button(
                  icon: Icons.g_mobiledata,
                  title: "Google",
                  onClick: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return const MobileVerify();
                    // }));
                  }),
              addVerticalSpace(30),
              //github
              Button(
                  icon: Icons.four_g_plus_mobiledata_rounded,
                  title: "Github",
                  onClick: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return const MobileVerify();
                    // }));
                  }),
              addVerticalSpace(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(("don't have an account?")),
                  addHorizontalSpace(30),
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
            ],
          ),
        ),
      ),
    );
  }
}
