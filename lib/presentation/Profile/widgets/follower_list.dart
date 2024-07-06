import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media/BLoC/Follow/follow_bloc.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/Profile/other_user_profile_screen.dart';

class FollowerList extends StatelessWidget {
  final FeatchFollowerSuccessState state;
  const FollowerList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: state.followerList.isEmpty
          ? Center(
              child: Text(
                "No Follower",
                style: theme.textTheme.titleLarge,
              ),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtherUserProfileScreen(
                            user: state.followerList[index],),
                      )),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: transparentColor,
                    child: CachedNetworkImage(
                      imageUrl: state.followerList[index].profilePic,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 30,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) => ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: imageLoadingShimmer(),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                      ),
                    ),
                  ),
                  title: Text(state.followerList[index].userName),
                  // trailing: CustomButton(
                  //   title: "Remove",
                  //   minWidth: 15,
                  //   color: theme.brightness == Brightness.dark
                  //       ? darkModeCustomButtonBG
                  //       : lightModeCustomButtonBG,
                  //   onTap: () {
                  //     log("remove");
                  //   },
                  // ),
                );
              },
              separatorBuilder: (context, index) => constHeight20,
              itemCount: state.followerList.length,
            ),
    );
  }
}
