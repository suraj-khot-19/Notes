import 'package:firebase1/Widget/support_widget/button.dart';
import 'package:firebase1/Widget/support_widget/controllers.dart';
import 'package:firebase1/Widget/support_widget/sized_box.dart';
import 'package:firebase1/Widget/support_widget/text_feild.dart';
import 'package:firebase1/Widget/utils/all_management.dart';
import 'package:firebase1/Widget/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyPostScreen extends StatefulWidget {
  const MyPostScreen({super.key});
// 7TfGJVwa1aWSy4PD0i9L6tadVtf2
  @override
  State<MyPostScreen> createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  bool loading = false;
  final _auth = FirebaseAuth.instance;

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
                  'assets/images/app_logo.png',
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
          child: Column(
            children: [
              addVerticalSpace(50),
              Text(
                "Add New Note",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.cyan,
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
              addVerticalSpace(80),
              textField(
                post,
                "What is in your Mind?",
                true,
                false,
                4,
              ),
              addVerticalSpace(50),
              Button(
                loading: loading,
                title: "Add",
                onClick: () {
                  setState(() {
                    loading = true;
                  });

                  //logic to get user
                  User? myUser = _auth.currentUser;
                  String uid = myUser!.uid;
                  final databaseRef =
                      FirebaseDatabase.instance.ref('UserData').child(uid);
                  String day = DateTime.now().day.toString();
                  String month = DateTime.now().month.toString();
                  String year = DateTime.now().year.toString();
                  String date = "$day/$month/$year";
                  String id = DateTime.now().microsecondsSinceEpoch.toString();
                  databaseRef.child(id).set({
                    'Date': date,
                    'Note': post.text.toString().trim(),
                  }).then((value) {
                    Utils().toastMessage('Note added. ..');
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                  setState(() {
                    post.clear();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
