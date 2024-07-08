import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/UserPost/user_post_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/models/saved_post_model.dart';

import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';
import 'package:social_media/presentation/CustomWidgets/custom_snackbar.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

class SavedPostView extends StatelessWidget {
  final SavePostModel post;

  const SavedPostView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Background(
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocConsumer<UserPostBloc, UserPostState>(
              listener: (context, state) {
                if (state is DeletePostSuccessState) {
                  Navigator.pop(context);
                } else if (state is DeletePostErrorState) {
                  customSnackbar(
                      context: context,
                      message: state.error,
                      color: errorColor);
                } else if (state is DeletePostLoadingState) {}
              },
              builder: (context, state) {
                return Column(
                  children: [
                    const CustomAppbar(
                      title: "",
                      backButton: true,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            InkWell(
                              // onTap: () => Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => OtherUserProfileScreen(
                              //         user: post.userId,
                              //       ),
                              //     )),
                              child: CircleAvatar(
                                radius: 25,
                                child: CachedNetworkImage(
                                  imageUrl: post.user.profilePic,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 60,
                                    backgroundImage: imageProvider,
                                  ),
                                  placeholder: (context, url) => ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: imageLoadingShimmer()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                  ),
                                ),
                              ),
                            ),
                            constWidth10,
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  // onTap: () => Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => OtherUserProfileScreen(
                                  //         user: post.userId,
                                  //       ),
                                  //     )),
                                  child: Text(
                                    post.user.userName,
                                    style: theme.textTheme.titleLarge,
                                  ),
                                ),
                                Text(
                                  isEdited(
                                          dateTime1: post.createdAt,
                                          dateTime2: post.updatedAt)
                                      ? timeago.format(post.createdAt)
                                      : "${timeago.format(post.createdAt)}(Edited)",
                                  style: theme.textTheme.labelLarge,
                                )
                              ],
                            ),
                            const Spacer(),
                            // moreIcon ?? const SizedBox(),
                          ]),
                          constHeight10,
                          Text(
                            post.description,
                            style: theme.textTheme.titleMedium,
                          ),
                          constHeight10,
                          CachedNetworkImage(
                            imageUrl: post.image,
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return SizedBox(
                                  height: 300, child: imageLoadingShimmer());
                            },
                          ),
                          // BottomSection(postModel: postModel)
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  bool isEdited({
    required DateTime dateTime1,
    required DateTime dateTime2,
  }) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day &&
        dateTime1.hour == dateTime2.hour &&
        dateTime1.minute == dateTime2.minute &&
        dateTime1.second == dateTime2.second;
  }
}
