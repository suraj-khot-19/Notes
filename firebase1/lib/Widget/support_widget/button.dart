import 'package:firebase1/Widget/support_widget/sized_box.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final bool loading;
  final String title;
  final VoidCallback onClick;
  final IconData? icon;
  const Button(
      {required this.title,
      this.icon,
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
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.purple, borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: loading
                  ? const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.blue,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) Icon(icon),
                        if (icon != null) addHorizontalSpace(5),
                        addHorizontalSpace(5),
                        Text(
                          title,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    )),
        ),
      ),
    );
  }
}
