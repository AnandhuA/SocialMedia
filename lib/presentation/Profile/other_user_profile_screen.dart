import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:social_media/BLoC/UserPost/user_post_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/presentation/CustomWidgets/custom_button.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/PostView/post_view_screen.dart';

class OtherUserProfileScreen extends StatefulWidget {
  final UserModel user;

  const OtherUserProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  @override
  void initState() {
    context.read<UserPostBloc>().add(FeatchUserPostEvent(user: widget.user));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  flexibleSpace: Stack(
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: widget.user.backGroundImage,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => imageLoadingShimmer(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: whiteColor,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.transparent,
                            backgroundImage: CachedNetworkImageProvider(
                              widget.user.profilePic,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      constHeight20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.user.name ?? widget.user.userName,
                          style: theme.textTheme.headlineLarge,
                        ),
                      ),
                      constHeight20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.user.bio ?? "",
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      constHeight30,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomButton(
                            color: whiteColor,
                            title: "Edit Profile",
                            minWidth: 150,
                            onTap: () {
                              // Navigate to edit profile screen
                            },
                          ),
                          CustomButton(
                            color: whiteColor,
                            title: "Settings",
                            minWidth: 150,
                            onTap: () {
                              // Navigate to settings screen
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ];
            },
            body: BlocBuilder<UserPostBloc, UserPostState>(
              builder: (context, state) {
                if (state is FeatchUserPostSuccessState) {
                  final posts = state.postList;
                  if (posts.isEmpty) {
                    return const Center(
                      child: Text("No Posts"),
                    );
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                    ),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostViewScreen(
                                post: posts[index],
                              ),
                            ),
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: posts[index].image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => imageLoadingShimmer(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      );
                    },
                  );
                } else {
                  return postGridShimmerEffect(
                      itemCount: 9); // Placeholder or shimmer effect
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
