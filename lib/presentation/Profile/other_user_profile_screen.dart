import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/presentation/CustomWidgets/custom_button.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';

class OtherUserProfileScreen extends StatelessWidget {
  final UserModel user;

  const OtherUserProfileScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
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
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            user.backGroundImage,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: user.backGroundImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return Center(
                            child: imageLoadingShimmer(),
                          );
                        },
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
                          backgroundColor: transparentColor,
                          child: CachedNetworkImage(
                            imageUrl: user.profilePic,
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: 60,
                              backgroundImage: imageProvider,
                            ),
                            placeholder: (context, url) => ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: imageLoadingShimmer()),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                constHeight20,
                Text(
                  user.name ?? user.userName,
                  style: theme.textTheme.headlineLarge,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    user.bio ?? "",
                    style: theme.textTheme.labelLarge,
                  ),
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
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => EditProfileScreen(
                        //         userDetails: state.userDetails,
                        //       ),
                        //     ));
                      },
                    ),
                    CustomButton(
                      title: "Settings",
                      minWidth: 150,
                      color: theme.brightness == Brightness.dark
                          ? darkModeCustomButtonBG
                          : lightModeCustomButtonBG,
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const SettingsScreen(),
                        //   ),
                        // );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
