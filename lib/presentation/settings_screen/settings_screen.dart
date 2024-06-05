import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/custom_widgets/confirmation_diloge.dart';
import 'package:social_media/presentation/custom_widgets/custom_appbar.dart';
import 'package:social_media/presentation/settings_screen/widgets/list_tile_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    confirmBtn: () {
                      log("mone set");
                    });
              },
            ),
            const Spacer(),
            const Text("v1.0"),
            constHeight50,
          ],
        ),
      ),
    );
  }
}
