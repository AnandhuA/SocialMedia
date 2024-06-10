import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Background(
        child: Center(
          child: Text("NotificationScreen"),
        ),
      ),
    );
  }
}
