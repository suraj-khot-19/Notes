import 'package:firebase1/Widget/support_widget/sized_box.dart';
import 'package:firebase1/Widget/utils/exit_confirm.dart';
import 'package:firebase1/screens/add_post.dart';
import 'package:firebase1/verify_screens/auth/Email/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final _auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.ref('Table');

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
            content: const Text("Are you sure you want to logout?",
                style: TextStyle(color: Colors.black, fontSize: 16)),
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
          Row(
            children: [
              IconButton(
                onPressed: () => _confirmLogout(),
                icon: const Icon(Icons.logout),
              ),
              const Text("usename"),
            ],
          ),
          addHorizontalSpace(10),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const MyPostScreen();
          }));
        },
        child: const Icon(Icons.post_add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const ExitConfirmationDialog(),
            Expanded(
              child: FirebaseAnimatedList(
                  defaultChild: const Text(
                    "Loading..",
                    style: TextStyle(
                      fontSize: 60,
                    ),
                  ),
                  query: databaseRef,
                  itemBuilder: (context, snapshot, animation, index) {
                    return ListTile(
                      title: Text(snapshot.child('id').value.toString()),
                      subtitle: Text(snapshot.child('name').value.toString()),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
