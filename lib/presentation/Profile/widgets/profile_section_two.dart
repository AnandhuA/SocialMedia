import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/Follow/follow_bloc.dart';
import 'package:social_media/BLoC/UserPost/user_post_bloc.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/CustomWidgets/custom_snackbar.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/PostView/post_view_screen.dart';
import 'package:social_media/presentation/Profile/follow_screen.dart';
import 'package:social_media/presentation/Profile/post_list_screen.dart';
import 'package:social_media/presentation/Profile/widgets/profile_info_button.dart';

class ProfileSectionTwo extends StatelessWidget {
  const ProfileSectionTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: BlocConsumer<UserPostBloc, UserPostState>(
        listener: (context, state) {
          if (state is FeatchAllMyPostErrorState) {
            customSnackbar(
                context: context, message: state.error, color: errorColor);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              constHeight30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileInfoButton(
                    onTapFun: () {
                      state is FeatchAllMyPostSuccessState
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PostListScreen(postList: state.postList),
                              ))
                          : null;
                    },
                    count: state is FeatchAllMyPostSuccessState
                        ? state.postList.length.toString()
                        : "...",
                    title: "Posts",
                  ),
                  ProfileInfoButton(
                    onTapFun: () {
                      context.read<FollowBloc>().add(FeatchFollowerListEvent());
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FollowScreen(
                            follwing: false,
                          ),
                        ),
                      );
                    },
                    count: state is FeatchAllMyPostSuccessState
                        ? state.followersCount
                        : "...",
                    title: "Follower",
                  ),
                  ProfileInfoButton(
                    onTapFun: () {
                      context.read<FollowBloc>().add(FeatchFollwingListEvent());
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FollowScreen(
                            follwing: true,
                          ),
                        ),
                      );
                    },
                    count: state is FeatchAllMyPostSuccessState
                        ? state.followingCount
                        : "...",
                    title: "Following",
                  )
                ],
              ),
              constHeight30,
              const TabBar(
                dividerColor: greyColor,
                tabs: [
                  Tab(text: 'Posts'),
                  Tab(text: 'Saved'),
                ],
              ),
              constHeight10,
              Expanded(
                child: TabBarView(
                  children: [
                    state is FeatchAllMyPostSuccessState
                        ? state.postList.isEmpty
                            ? Center(
                                child: Text(
                                  "No Post",
                                  style: theme.textTheme.titleLarge,
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 3,
                                ),
                                itemCount: state.postList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PostViewScreen(
                                            post: state.postList[index],
                                            editpost: true,
                                          ),
                                        )),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            state.postList[index].image,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: state.postList[index].image,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) {
                                          return Center(
                                              child: imageLoadingShimmer());
                                        },
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  );
                                },
                              )
                        : postGridShimmerEffect(itemCount: 9),
                    state is FeatchAllMyPostSuccessState
                        ? state.savedPostList.isEmpty
                            ? Center(
                                child: Text(
                                  "No Post",
                                  style: theme.textTheme.titleLarge,
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 3,
                                ),
                                itemCount: state.savedPostList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    // onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => PostViewScreen(post: state.savedPostList[index]),)),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            state.savedPostList[index].image,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                        : postGridShimmerEffect(itemCount: 9)
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

