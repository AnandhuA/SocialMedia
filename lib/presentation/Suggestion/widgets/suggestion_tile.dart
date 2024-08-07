import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/Follow/follow_bloc.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/presentation/CustomWidgets/custom_button.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/Profile/other_user_profile_screen.dart';

class SuggestionTile extends StatefulWidget {
  final UserModel suggessionUser;
  const SuggestionTile({super.key, required this.suggessionUser});

  @override
  State<SuggestionTile> createState() => _SuggestionTileState();
}

class _SuggestionTileState extends State<SuggestionTile> {
  bool isfollow = false;
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
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtherUserProfileScreen(
                      user: widget.suggessionUser,
                    ),
                  ));
            },
            child: SizedBox(
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
                          widget.suggessionUser.backGroundImage??"https://images.pexels.com/photos/255379/pexels-photo-255379.jpeg?auto=compress&cs=tinysrgb&w=600",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.suggessionUser.backGroundImage??"https://images.pexels.com/photos/255379/pexels-photo-255379.jpeg?auto=compress&cs=tinysrgb&w=600",
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
                        imageUrl: widget.suggessionUser.profilePic??"https://res.cloudinary.com/di9yf5j0d/image/upload/v1695795823/om0qyogv6dejgjseakej.png",
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
          ),
          const Spacer(),
          Text(
            widget.suggessionUser.userName,
            style: theme.textTheme.titleLarge,
          ),
          const Spacer(),
          BlocConsumer<FollowBloc, FollowState>(
            listener: (context, state) {
              if (state is FollowUserErrorState) {
                isfollow = false;
              }
            },
            builder: (context, state) {
              if (state is FollowUserSuccessState &&
                      state.connectionUserId
                          .contains(widget.suggessionUser.id) ||
                  isfollow) {
                return SizedBox(
                    height: 30,
                    width: 150,
                    child: CustomButton(
                      title: "UnFollow",
                      minWidth: 5,
                      color: theme.brightness == Brightness.dark
                          ? darkModeCustomButtonBG
                          : lightModeCustomButtonBG,
                      onTap: () {
                        context.read<FollowBloc>().add(UnFollowButtonClickEvent(
                            user: widget.suggessionUser));
                        setState(() {
                          isfollow = false;
                        });
                      },
                    ));
              }

              return SizedBox(
                height: 30,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<FollowBloc>().add(
                        FollowButtonClickEvent(user: widget.suggessionUser));
                    setState(() {
                      isfollow = true;
                    });
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
