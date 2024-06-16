import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/CustomWidgets/custom_button.dart';
import 'package:social_media/presentation/Settings/settings_screen.dart';

class ProfileSectionOne extends StatelessWidget {
  const ProfileSectionOne({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: size.height * 0.3,
              width: double.infinity,
            ),
            Positioned(
                child: Container(
              width: double.infinity,
              height: size.height * 0.23,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRd8CLOYSV_UvfBrSm5loSGt0XaD7j_3lDRDw&s",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRd8CLOYSV_UvfBrSm5loSGt0XaD7j_3lDRDw&s",
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: greyColor,
                      size: 30,
                    ),
                  );
                },
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            )),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: whiteColor,
                  radius: 65,
                  child: CircleAvatar(
                    radius: 60,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://imgv3.fotor.com/images/blog-cover-image/10-profile-picture-ideas-to-make-you-stand-out.jpg",
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 60,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) => Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                      ),
                    ),
                  ),
                ))
          ],
        ),
        Text(
          "Anandhu",
          style: theme.textTheme.headlineLarge,
        ),
        constHeight30,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomButton(
              title: "Edit Profile",
              minWidth: 150,
              color: theme.brightness == Brightness.dark
                  ? darkModeCustomButtonBG
                  : lightModeCustomButtonBG,
              onTap: () {
                log("message");
              },
            ),
            CustomButton(
              title: "Settings",
              minWidth: 150,
              color: theme.brightness == Brightness.dark
                  ? darkModeCustomButtonBG
                  : lightModeCustomButtonBG,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
