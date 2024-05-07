import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final bool loading;
  final String title;
  final VoidCallback onClick;
  const Button(
      {required this.title,
      required this.onClick,
      super.key,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Center(
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.purple, borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: loading
                  ? const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.blue,
                    )
                  : Text(
                      title,
                      style: const TextStyle(fontSize: 18),
                    )),
        ),
      ),
    );
  }
}
