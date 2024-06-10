import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Background(
        child: Center(
          child: Text("SearchScreen"),
        ),
      ),
    );
  }
}
