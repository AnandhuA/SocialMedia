import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/FollowingPost/following_post_bloc.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/presentation/CustomWidgets/comment_bottomsheet.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/Home/widgets/post_reaction_button.dart';
import 'package:social_media/presentation/Profile/other_user_profile_screen.dart';
import 'package:social_media/repository/authentication/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  final PostModel postModel;

  final Widget? moreIcon;
  const PostWidget({
    super.key,
    this.moreIcon,
    required this.postModel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtherUserProfileScreen(
                      user: postModel.userId,
                    ),
                  )),
              child: CircleAvatar(
                radius: 25,
                child: CachedNetworkImage(
                  imageUrl: postModel.userId.profilePic,
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
            constWidth10,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtherUserProfileScreen(
                          user: postModel.userId,
                        ),
                      )),
                  child: Text(
                    postModel.userId.userName,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                Text(
                  isEdited(
                          dateTime1: postModel.createdAt,
                          dateTime2: postModel.updatedAt)
                      ? timeago.format(postModel.createdAt)
                      : "${timeago.format(postModel.createdAt)}(Edited)",
                  style: theme.textTheme.labelLarge,
                )
              ],
            ),
            const Spacer(),
            moreIcon ?? const SizedBox(),
          ]),
          constHeight10,
          Text(
            postModel.description,
            style: theme.textTheme.titleMedium,
          ),
          constHeight10,
          CachedNetworkImage(
            imageUrl: postModel.image,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return SizedBox(height: 300, child: imageLoadingShimmer());
            },
          ),
          BottomSection(postModel: postModel)
        ],
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

class BottomSection extends StatefulWidget {
  const BottomSection({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  State<BottomSection> createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  late bool isSaved;
  late bool isLiked;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    isSaved = widget.postModel.isSaved;
    isLiked = widget.postModel.isLiked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BlocBuilder<FollowingPostBloc, FollowingPostState>(
            builder: (context, state) {
              return state is LikeLoadingState
                  ? PostReactionButton(
                      icon: isLiked ? Icons.favorite : Icons.favorite_border,
                      count: isLiked
                          ? ((widget.postModel.likes.length) + 1).toString()
                          : ((widget.postModel.likes.length) - 1).toString(),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                        widget.postModel.isLiked
                            ? context
                                .read<FollowingPostBloc>()
                                .add(UnLikeEvent(post: widget.postModel))
                            : context
                                .read<FollowingPostBloc>()
                                .add(LikeEvent(post: widget.postModel));
                      },
                      child: PostReactionButton(
                        icon: widget.postModel.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        count: widget.postModel.likes.length.toString(),
                      ),
                    );
            },
          ),
          InkWell(
              onTap: () async {
                log(widget.postModel.commentCount.toString());
                final String? profilePic = await getUserProfilePic();
                context
                    .read<FollowingPostBloc>()
                    .add(CommentButtonClickEvent(post: widget.postModel));
                commentBottomSheet(
                  formkey: _formKey,
                  context: context,
                  commentController: TextEditingController(),
                  id: widget.postModel.id,
                  post: widget.postModel,
                  profilePic: profilePic ??
                      "https://res.cloudinary.com/di9yf5j0d/image/upload/v1695795823/om0qyogv6dejgjseakej.png",
                );
              },
              child: PostReactionButton(
                icon: Icons.comment,
                count: widget.postModel.commentCount.toString(),
              )),
          BlocBuilder<FollowingPostBloc, FollowingPostState>(
            builder: (context, state) {
              return state is SavePostLoadingState
                  ? isSaved
                      ? const PostReactionButton(
                          icon: Icons.bookmark,
                          count: "",
                        )
                      : const PostReactionButton(
                          icon: Icons.bookmark_border_outlined,
                          count: "",
                        )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          isSaved = !isSaved;
                        });
                        widget.postModel.isSaved
                            ? context.read<FollowingPostBloc>().add(
                                  UnSaveButtonClickEvent(
                                    post: widget.postModel,
                                  ),
                                )
                            : context.read<FollowingPostBloc>().add(
                                  SaveButtonClickEvent(
                                    post: widget.postModel,
                                  ),
                                );
                      },
                      child: widget.postModel.isSaved
                          ? const PostReactionButton(
                              icon: Icons.bookmark,
                              count: "",
                            )
                          : const PostReactionButton(
                              icon: Icons.bookmark_border_outlined,
                              count: "",
                            ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
