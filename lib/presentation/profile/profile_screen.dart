import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
          child: Center(
        child: Text("profile"),
      )),
    );
  }
}
