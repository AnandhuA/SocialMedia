import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/verificatio_screen/widgets/otp_text_filed.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Verification",
              style: theme.textTheme.headlineLarge,
            ),
            constHeight10,
            Text(
              "We have send verification code\n to your Email",
              style: theme.textTheme.labelLarge,
            ),
            constHeight30,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                textBoxWidget(context: context, controller: otpController1),
                textBoxWidget(context: context, controller: otpController2),
                textBoxWidget(context: context, controller: otpController3),
                textBoxWidget(context: context, controller: otpController4),
              ],
            ),
            constHeight50,
            ElevatedButton(onPressed: () {}, child: const Text("Confirm"))
          ],
        ),
      ),
    );
  }
}
