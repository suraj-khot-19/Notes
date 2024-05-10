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
  @override
  State<MyPostScreen> createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  bool _isMounted = false;
  @override
  void initState() {
    super.initState();
    _isMounted = true;
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
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
              Form(
                key: formKey,
                child: textField(
                  note,
                  "What is in your Mind?",
                  true,
                  false,
                  4,
                ),
              ),
              addVerticalSpace(50),
              Button(
                  loading: loading,
                  title: "Add",
                  onClick: () {
                    if (formKey.currentState!.validate()) {
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
                      String id =
                          DateTime.now().microsecondsSinceEpoch.toString();
                      databaseRef.child(id).set({
                        'Id': id,
                        'Date': date,
                        'Note': note.text.toString().trim(),
                      }).then((value) {
                        if (_isMounted) {
                          // Check if the widget is still mounted
                          Utils().toastMessage('Note added...');
                          setState(() {
                            loading = false;
                          });

                          // Navigate back to the home page
                          Navigator.pop(context);
                        }
                      }).onError((error, stackTrace) {
                        if (_isMounted) {
                          // Check if the widget is still mounted
                          Utils().toastMessage(error.toString());
                          setState(() {
                            loading = false;
                          });
                        }
                      });
                      setState(() {
                        note.clear();
                      });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
