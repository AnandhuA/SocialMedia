import 'package:flutter/material.dart';

Widget textBoxWidget({
  required BuildContext context,
  required TextEditingController controller,
}) {
  return Container(
    height: 80,
    width: 70,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 1,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 30),
      decoration: const InputDecoration(counterText: ""),
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        } else {
          FocusScope.of(context).previousFocus();
        }
      },
    ),
  );
}
