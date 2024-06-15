import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/UserPost/user_post_bloc.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/CustomWidgets/custom_snackbar.dart';
import 'package:social_media/presentation/PostView/post_view_screen.dart';
import 'package:social_media/presentation/Profile/widgets/profile_info_button.dart';

class ProfileSectionTwo extends StatelessWidget {
  const ProfileSectionTwo({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          constHeight30,
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileInfoButton(
                count: "03",
                title: "Posts",
              ),
              ProfileInfoButton(
                count: "234",
                title: "Follower",
              ),
              ProfileInfoButton(
                count: "302",
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
          BlocConsumer<UserPostBloc, UserPostState>(
            listener: (context, state) {
              if (state is FeatchAllMyPostErrorState) {
                customSnackbar(
                    context: context, message: state.error, color: errorColor);
              }
            },
            builder: (context, state) {
              return Expanded(
                child: TabBarView(
                  children: [
                    state is FeatchAllMyPostSuccessState
                        ? GridView.builder(
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
                                      image: NetworkImage(
                                        state.postList[index].image,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
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
              );
            },
          ),
        ],
      ),
    );
  }
}

List dummylistpost = [
  "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREoRGyXmHy_6aIgXYqWHdOT3KjfmnuSyxypw&s",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4s4lswDnx95hVyzQEzWYtFEpQTs42NmxtqHqsweX6hU-GbZxJfYgeKa2LIuTiKf0O7Gg"
];
List dummylistsaved = [
  "https://media.istockphoto.com/id/1317323736/photo/a-view-up-into-the-trees-direction-sky.jpg?s=612x612&w=0&k=20&c=i4HYO7xhao7CkGy7Zc_8XSNX_iqG0vAwNsrH1ERmw2Q=",
  "https://media.istockphoto.com/id/1296344118/photo/beautiful-happy-woman-enjoying-the-warm-sunlight-in-a-tropical-public-park.jpg?s=612x612&w=0&k=20&c=Z0h4uIzZd4cxhkT_CSl9-1wFbnbuqEWYrp5heM9uDuQ=",
  "https://media.istockphoto.com/id/1314559532/photo/relaxed-woman-breathing-fresh-air-in-a-green-forest.jpg?s=612x612&w=0&k=20&c=_LPHSLjVO_ZDMatEHl_62i6RW-6IpnHgjoG3aIDPY2A="
];
