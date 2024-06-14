import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media/core/colors.dart';

class LoadingButton extends StatelessWidget {
  final Color color;
  const LoadingButton({super.key, this.color = primaryColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle().copyWith(
        backgroundColor: WidgetStatePropertyAll(
          color,
        ),
      ),
      onPressed: () {},
      child: Lottie.asset(
        "assets/animations/buttonLoading.json",
        height: 60,
      ),
    );
  }
}
