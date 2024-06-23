import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/FeatchFollowing/featch_following_bloc.dart';

import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';
import 'package:social_media/presentation/CustomWidgets/custom_button.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';

class FollowingListScreen extends StatelessWidget {
  const FollowingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocConsumer<FeatchFollowingBloc, FeatchFollowingState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Column(
                  children: [
                    const CustomAppbar(
                      title: "",
                      backButton: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                          title: "Following",
                          minWidth: 15,
                          color: primaryColor,
                          onTap: () {
                            log("Following");
                          },
                        ),
                        CustomButton(
                          title: "Following",
                          minWidth: 15,
                          color: theme.brightness == Brightness.dark
                              ? darkModeCustomButtonBG
                              : lightModeCustomButtonBG,
                          onTap: () {
                            log("Following");
                          },
                        ),
                      ],
                    ),
                    constHeight20,
                    const SizedBox(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search",
                        ),
                      ),
                    ),
                    constHeight10,
                    state is FeatchFollowingSuccessState
                        ? Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: transparentColor,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          state.follwingList[index].profilePic,
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                        radius: 30,
                                        backgroundImage: imageProvider,
                                      ),
                                      placeholder: (context, url) => ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: imageLoadingShimmer(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error,
                                      ),
                                    ),
                                  ),
                                  title:
                                      Text(state.follwingList[index].userName),
                                  trailing: CustomButton(
                                    title: "Remove",
                                    minWidth: 15,
                                    color: theme.brightness == Brightness.dark
                                        ? darkModeCustomButtonBG
                                        : lightModeCustomButtonBG,
                                    onTap: () {
                                      log("remove");
                                    },
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  constHeight20,
                              itemCount: state.follwingList.length,
                            ),
                          )
                        : followingListLoading(iteamCount: 10)
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
