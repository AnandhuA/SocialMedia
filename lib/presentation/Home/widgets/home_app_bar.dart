import 'package:flutter/material.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/Home/widgets/profile_icon_widget.dart';
import 'package:social_media/presentation/Profile/profile_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        constWidth20,
        Text(
          "Hi,Anandhu",
          style: theme.textTheme.headlineMedium,
        ),
        const Spacer(),
        ProfileIconWidget(
          child: const Icon(Icons.person),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ));
          },
        )
      ],
    );
  }
}
