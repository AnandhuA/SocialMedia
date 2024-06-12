import 'package:flutter/material.dart';
import 'package:social_media/core/size.dart';

class PostReactionButton extends StatelessWidget {
  final IconData icon;
  final String count;
  const PostReactionButton({
    super.key,
    required this.icon,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon),
        constWidth10,
        Text(
          count,
          style: theme.textTheme.titleMedium,
        ),
      ],
    );
  }
}
