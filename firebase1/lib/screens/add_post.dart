import 'package:firebase1/Widget/support_widget/button.dart';
import 'package:firebase1/Widget/support_widget/controllers.dart';
import 'package:firebase1/Widget/support_widget/sized_box.dart';
import 'package:firebase1/Widget/support_widget/text_feild.dart';
import 'package:firebase1/Widget/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyPostScreen extends StatefulWidget {
  const MyPostScreen({super.key});

  @override
  State<MyPostScreen> createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Table');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Add Post To\nFirebase DataBase",
              style: TextStyle(fontSize: 30),
            ),
            addVerticalSpace(80),
            textField(
                post, "Add Post To \n Firebase DataBase", true, false, 4, null),
            addVerticalSpace(50),
            Button(
              loading: loading,
              title: "Post",
              onClick: () {
                setState(() {
                  loading = true;
                });
                String id = DateTime.now().microsecond.toString();
                databaseRef.child(id).set({
                  'id': id,
                  'name': post.text.toString(),
                }).then((value) {
                  Utils().toastMessage('Post added');
                  setState(() {
                    loading = false;
                  });
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                  setState(() {
                    loading = false;
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
