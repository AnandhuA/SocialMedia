import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';

class EditProfileScreen extends StatelessWidget {
  final UserModel userDetails;
  const EditProfileScreen({super.key, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Column(
          children: [
            const CustomAppbar(
              title: "Edit Profile",
              backButton: true,
            ),
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
                        userDetails.backGroundImage,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: userDetails.backGroundImage,
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
                        imageUrl: userDetails.profilePic,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 60,
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (context, url) => ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: imageLoadingShimmer(),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Text(userDetails.userName)
          ],
        ),
      ),
    );
  }
}
