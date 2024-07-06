import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final bool backButton;
  final Widget actionButton;
  const CustomAppbar({
    super.key,
    required this.title,
    this.backButton = false,
    this.actionButton = const SizedBox(
      width: 50,
    ),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            backButton
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  )
                : const SizedBox(),
            Text(
              title,
              style: theme.textTheme.headlineLarge,
            ),
            actionButton,
          ],
        ),
      ),
    );
  }
}
