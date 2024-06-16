import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/Home/widgets/post_reaction_button.dart';

class PostWidget extends StatelessWidget {
  final String postUrl;
  final String description;
  final String userName;
  final String likeCount;
  final String commentCount;
  final String time;
  final Widget? moreIcon;
  final String profilePic;
  const PostWidget({
    super.key,
    required this.postUrl,
    required this.description,
    required this.userName,
    required this.likeCount,
    required this.commentCount,
    required this.time,
    required this.profilePic,
    this.moreIcon,
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
            CircleAvatar(
              radius: 25,
              child: CachedNetworkImage(
                imageUrl: profilePic,
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
            constWidth10,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: theme.textTheme.titleLarge,
                ),
                Text(
                  time,
                  style: theme.textTheme.labelLarge,
                )
              ],
            ),
            const Spacer(),
            moreIcon ?? const SizedBox(),
          ]),
          constHeight10,
          Text(
            description,
            style: theme.textTheme.titleMedium,
          ),
          constHeight10,
          CachedNetworkImage(
            imageUrl: postUrl,
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
                PostReactionButton(icon: Icons.favorite, count: likeCount),
                PostReactionButton(icon: Icons.comment, count: commentCount),
                const PostReactionButton(icon: Icons.save, count: "12"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
