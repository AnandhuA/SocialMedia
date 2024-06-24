import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';

class SuggestionTile extends StatelessWidget {
  final UserModel suggessionUser;
  const SuggestionTile({super.key, required this.suggessionUser});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
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
                  top: 30,
                  right: 0,
                  left: 0,
                  child: CircleAvatar(
                    radius: 50,
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
          Text(
            suggessionUser.userName,
            style: theme.textTheme.titleLarge,
          ),
          constHeight10,
          SizedBox(
            height: 30,
            width: 150,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Follow",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          constHeight10
        ],
      ),
    );
  }
}
