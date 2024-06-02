import 'package:flutter/material.dart';

class ProfileInfoButton extends StatelessWidget {
  final String count;
  final String title;
  const ProfileInfoButton({
    super.key,
    required this.count,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          count,
          style: theme.textTheme.titleLarge,
        ),
        Text(
          title,
          style: theme.textTheme.titleLarge,
        ),
      ],
    );
  }
}
