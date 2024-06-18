import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/UserPost/user_post_bloc.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/CustomWidgets/custom_snackbar.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/PostView/post_view_screen.dart';
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
                    count: state is FeatchAllMyPostSuccessState
                        ? state.postList.length.toString()
                        : "...",
                    title: "Posts",
                  ),
                  ProfileInfoButton(
                    count: state is FeatchAllMyPostSuccessState
                        ? state.followersCount
                        : "...",
                    title: "Follower",
                  ),
                  ProfileInfoButton(
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
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                      ),
                      itemCount: dummylistsaved.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                dummylistsaved[index],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
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

List dummylistsaved = [
  "https://media.istockphoto.com/id/1317323736/photo/a-view-up-into-the-trees-direction-sky.jpg?s=612x612&w=0&k=20&c=i4HYO7xhao7CkGy7Zc_8XSNX_iqG0vAwNsrH1ERmw2Q=",
  "https://media.istockphoto.com/id/1296344118/photo/beautiful-happy-woman-enjoying-the-warm-sunlight-in-a-tropical-public-park.jpg?s=612x612&w=0&k=20&c=Z0h4uIzZd4cxhkT_CSl9-1wFbnbuqEWYrp5heM9uDuQ=",
  "https://media.istockphoto.com/id/1314559532/photo/relaxed-woman-breathing-fresh-air-in-a-green-forest.jpg?s=612x612&w=0&k=20&c=_LPHSLjVO_ZDMatEHl_62i6RW-6IpnHgjoG3aIDPY2A="
];
