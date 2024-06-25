
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/Follow/follow_bloc.dart';

import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';
import 'package:social_media/presentation/CustomWidgets/custom_button.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/Profile/widgets/follower_list.dart';
import 'package:social_media/presentation/Profile/widgets/following_list.dart';

class FollowScreen extends StatelessWidget {
  bool follwing;
  FollowScreen({super.key, required this.follwing});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocConsumer<FollowBloc, FollowState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Column(
                  children: [
                    const CustomAppbar(
                      title: "",
                      backButton: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                          title: "Follower",
                          minWidth: 15,
                          color: follwing
                              ? theme.brightness == Brightness.dark
                                  ? darkModeCustomButtonBG
                                  : lightModeCustomButtonBG
                              : primaryColor,
                          onTap: () {
                            follwing = !follwing;
                            context
                                .read<FollowBloc>()
                                .add(FeatchFollowerListEvent());
                          },
                        ),
                        CustomButton(
                          title: "Following",
                          minWidth: 15,
                          color: follwing
                              ? primaryColor
                              : theme.brightness == Brightness.dark
                                  ? darkModeCustomButtonBG
                                  : lightModeCustomButtonBG,
                          onTap: () {
                            follwing = !follwing;
                            context
                                .read<FollowBloc>()
                                .add(FeatchFollwingListEvent());

                          },
                        ),
                      ],
                    ),
                    constHeight20,
                    const SizedBox(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search",
                        ),
                      ),
                    ),
                    constHeight10,
                    BlocBuilder<FollowBloc, FollowState>(
                      builder: (context, state) {
                        if (state is FeatchFollowerSuccessState) {
                          return FollowerList(state: state);
                        } else if (state is FeatchFollowingSuccessState) {
                          return FollowingList(state: state);
                        } else if (state is FeatchFollowingLoadingState) {
                          return followingListLoading(iteamCount: 10);
                        }
                        return Container(
                          color: errorColor,
                          child: Center(
                            child: Text("error"),
                          ),
                        );
                      },
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
