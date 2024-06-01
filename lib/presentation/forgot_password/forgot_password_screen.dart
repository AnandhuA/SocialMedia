import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/forgot_password/new_password_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Forgot password",
          style: theme.textTheme.headlineLarge,
        ),
      ),
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Please enter your email adderss,\nYou will receive a 4 digit code to verify",
                style: theme.textTheme.labelLarge,
              ),
            ),
            constHeight50,
            Text(
              "Email",
              style: theme.textTheme.titleLarge,
            ),
            constHeight10,
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Enter your email",
              ),
              style: theme.textTheme.titleLarge,
            ),
            constHeight50,
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewPasswordScreen(),
                    ));
              },
              child: const Text("Send OTP"),
            )
          ],
        ),
      ),
    );
  }
}
