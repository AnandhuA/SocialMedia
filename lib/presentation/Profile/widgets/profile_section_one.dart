import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/UserDetails/user_details_bloc.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/CustomWidgets/custom_button.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/Profile/edit__profile.dart';
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
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
        builder: (context, state) {
      if (state is FeatchUserDetailsSuccessState) {
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        state.userDetails.backGroundImage,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: state.userDetails.backGroundImage,
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
                        imageUrl: state.userDetails.profilePic,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
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
              state.userDetails.name ?? state.userDetails.userName,
              style: theme.textTheme.headlineLarge,
            ),
            Text(
              state.userDetails.bio ?? "",
              style: theme.textTheme.labelLarge,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                            userDetails: state.userDetails,
                          ),
                        ));
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
      } else if (state is FeatchUserDetailsLoadingState) {
        return profileLoadingShimmer();
      } else {
        return Center(
          child: Text(
            "Error",
            style: theme.textTheme.titleLarge,
          ),
        );
      }
    });
  }
}
