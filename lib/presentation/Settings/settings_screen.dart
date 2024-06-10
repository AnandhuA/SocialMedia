import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/CustomWidgets/confirmation_diloge.dart';
import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';
import 'package:social_media/presentation/Intro/intro_screen.dart';
import 'package:social_media/presentation/Settings/widgets/list_tile_widget.dart';
import 'package:social_media/repository/authentication/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Background(
        child: Column(
          children: [
            const CustomAppbar(
              title: "Settings",
              backButton: true,
            ),
            constHeight30,
            MultiListTileWidget(
              icon1: const Icon(Icons.info_outline),
              title1: "About",
              onTap1: () {
                log("about");
              },
              icon2: const Icon(Icons.privacy_tip_outlined),
              title2: "Privacy and policy",
              onTap2: () {
                log("privcy");
              },
            ),
            constHeight20,
            ListTileWidget(
              icon: const Icon(Icons.dark_mode_outlined),
              title: "Theme",
              onTap: () {
                log("theme");
              },
            ),
            constHeight20,
            ListTileWidget(
              icon: const Icon(
                Icons.login_outlined,
                color: errorColor,
              ),
              logout: true,
              title: "Log out",
              onTap: () {
                confirmationDiloge(
                    context: context,
                    title: "Confirm Logout",
                    content: "Are you sure you want to log out?",
                    confirmBtn: () async {
                      await clearUserSession();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IntroScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    });
              },
            ),
            const Spacer(),
            Text(
              "v1.0",
              style: theme.textTheme.titleMedium,
            ),
            constHeight50,
          ],
        ),
      ),
    );
  }
}
