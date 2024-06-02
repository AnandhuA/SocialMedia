import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Lottie.asset(
        "assets/animations/buttonLoading.json",
        height: 60,
      ),
    );
  }
}
