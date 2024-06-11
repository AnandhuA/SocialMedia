import 'package:flutter/material.dart';
import 'package:social_media/core/size.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                child: Icon(Icons.person),
              ),
              constWidth10,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Anandhu",
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    "20 min ago",
                    style: theme.textTheme.labelLarge,
                  )
                ],
              )
            ],
          ),
          constHeight10,
          Text(
            "Reloaded 1 of 1407.......",
            style: theme.textTheme.titleMedium,
          ),
          constHeight10,
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.favorite),
                Icon(Icons.comment),
                Icon(Icons.save),
              ],
            ),
          )
        ],
      ),
    );
  }
}
