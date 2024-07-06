import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/presentation/CustomWidgets/comment_bottomsheet.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/Home/widgets/post_reaction_button.dart';
import 'package:social_media/presentation/Profile/other_user_profile_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  final PostModel postModel;
  final Function likeOnTap;

  final Widget? moreIcon;
  const PostWidget(
      {super.key,
      this.moreIcon,
      required this.postModel,
      required this.likeOnTap});

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
          SizedBox(
            width: double.infinity,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => likeOnTap(),
                  child: PostReactionButton(
                    icon: Icons.favorite,
                    count: postModel.likes.length.toString(),
                  ),
                ),
                InkWell(
                    onTap: () {
                      commentBottomSheet(
                        context: context,
                        commentController: TextEditingController(),
                        id: postModel.id,
                      );
                    },
                    child: PostReactionButton(icon: Icons.comment, count: "")),
                const PostReactionButton(icon: Icons.save, count: "12"),
              ],
            ),
          )
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
