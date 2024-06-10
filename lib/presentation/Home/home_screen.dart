import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Text("Homescreen"),
        ),
      ),
    );
  }
}
