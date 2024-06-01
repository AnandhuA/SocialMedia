import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
          child: Center(
        child: Text("SignUp"),
      )),
    );
  }
}
