import 'package:flutter/material.dart';

import 'package:social_media/core/bacground.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Column(
            children: [
              // Image.asset(
              //   "assets/images/introImage1.png",
              // ),
              TextFormField(),
              const SizedBox(height: 20),
              TextField(),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: () {}, child: const Text("Log In")),
              const SizedBox(height: 20),
              TextButton(onPressed: () {}, child: const Text("Sign Up")),
              const SizedBox(height: 20),
              Text(
                "data",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                "data",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "data",
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
