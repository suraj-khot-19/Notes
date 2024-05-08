import 'package:firebase1/verify_screens/auth/login_screen.dart';
import 'package:firebase1/Widget/support_widget/controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final _auth = FirebaseAuth.instance;
  final String user = username.text.toString();

  Future<void> _confirmLogout() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            iconColor: Colors.black,
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
            icon: const Icon(Icons.cancel_presentation_sharp),
            title: const Text(
              "Confirm Logout",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            content: Text("$user \n are you sure you want to logout?",
                style: const TextStyle(color: Colors.black, fontSize: 16)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();

                  await _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () => _confirmLogout(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
