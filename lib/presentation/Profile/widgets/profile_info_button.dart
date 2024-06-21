import 'package:flutter/material.dart';

class ProfileInfoButton extends StatelessWidget {
  final String count;
  final String title;
  final Function onTapFun;
  const ProfileInfoButton({
    super.key,
    required this.count,
    required this.title,
    required this.onTapFun,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => onTapFun(),
      child: Column(
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
      ),
    );
  }
}
