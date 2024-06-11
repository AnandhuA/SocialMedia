import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/presentation/Home/widgets/home_app_bar.dart';
import 'package:social_media/presentation/Home/widgets/post_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Column(
            children: [
              const HomeAppBar(),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const PostWidget();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
