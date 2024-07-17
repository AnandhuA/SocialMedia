import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/Follow/follow_bloc.dart';
import 'package:social_media/BLoC/UserPost/user_post_bloc.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/CustomWidgets/custom_button.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/Profile/other_user_profile_screen.dart';

class FollowingList extends StatelessWidget {
  final FeatchFollowingSuccessState state;
  const FollowingList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: state.follwingList.isEmpty
          ? Center(
              child: Text(
                "No Following",
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
                          user: state.follwingList[index],
                        ),
                      )),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: transparentColor,
                    child: CachedNetworkImage(
                      imageUrl: state.follwingList[index].profilePic??"https://res.cloudinary.com/di9yf5j0d/image/upload/v1695795823/om0qyogv6dejgjseakej.png",
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
                  title: Text(state.follwingList[index].userName),
                  trailing: CustomButton(
                    title: "UnFollow",
                    minWidth: 15,
                    color: theme.brightness == Brightness.dark
                        ? darkModeCustomButtonBG
                        : lightModeCustomButtonBG,
                    onTap: ()  {
                      context.read<FollowBloc>().add(
                            UnFollowButtonClickEvent(
                              user: state.follwingList[index],
                            ),
                          );
                      context.read<FollowBloc>().add(FeatchFollwingListEvent());
                      context.read<UserPostBloc>().add(FeatchAllMyPostEvent());
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => constHeight20,
              itemCount: state.follwingList.length,
            ),
    );
  }
}
