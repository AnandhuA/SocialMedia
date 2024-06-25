import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/Follow/follow_bloc.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';

class SuggestionTile extends StatelessWidget {
  final UserModel suggessionUser;
  const SuggestionTile({super.key, required this.suggessionUser});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final double avatarRadius = screenWidth * 0.1;
    final double containerHeight = screenWidth * 0.35;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 135,
            child: Stack(
              children: [
                Container(
                  height: containerHeight * 0.6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        suggessionUser.backGroundImage,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: suggessionUser.backGroundImage,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Center(
                          child: imageLoadingShimmer(),
                        );
                      },
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  top: containerHeight * 0.25,
                  right: 0,
                  left: 0,
                  child: CircleAvatar(
                    radius: avatarRadius,
                    child: CachedNetworkImage(
                      imageUrl: suggessionUser.profilePic,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 50,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) =>
                          ClipRRect(child: imageLoadingShimmer()),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            suggessionUser.userName,
            style: theme.textTheme.titleLarge,
          ),
          const Spacer(),
          BlocBuilder<FollowBloc, FollowState>(
            builder: (context, state) {
              if (state is FollowUserSuccessState) {
                log("======================");

                return SizedBox(
                  height: 30,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<FollowBloc>()
                          .add(FollowButtonClickEvent(user: suggessionUser));
                    },
                    child: state.connectionUserId.contains(suggessionUser.id)
                        ? const Text(
                            "remove",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        : const Text(
                            "Loading",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                  ),
                );
              }

              return SizedBox(
                height: 30,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<FollowBloc>()
                        .add(FollowButtonClickEvent(user: suggessionUser));
                  },
                  child: const Text(
                    "Follow",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
