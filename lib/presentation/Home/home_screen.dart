import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/presentation/Home/widgets/home_app_bar.dart';
import 'package:social_media/presentation/CustomWidgets/post_widget.dart';

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
                    return const PostWidget(
                      postUrl:
                          "https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg",
                      description: "Welcome",
                      userName: "Anandhu",
                      likeCount: "14",
                      commentCount: "10",
                      time: "20 min ago",
                    );
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
