import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/size.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "New password",
          style: theme.textTheme.headlineLarge,
        ),
      ),
      body: Background(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            constHeight50,
            Text(
              "New password",
              style: theme.textTheme.titleLarge,
            ),
            constHeight10,
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "New Password",
              ),
              style: theme.textTheme.titleLarge,
            ),
            constHeight40,
            Text(
              "confirm password",
              style: theme.textTheme.titleLarge,
            ),
            constHeight10,
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "confirm password",
              ),
              style: theme.textTheme.titleLarge,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Save"),
            ),
            constHeight50
          ],
        ),
      ),
    );
  }
}
