import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/FollowingPost/following_post_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/Home/widgets/home_app_bar.dart';
import 'package:social_media/presentation/CustomWidgets/post_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<FollowingPostBloc>().add(FeatchAllFollowingPostEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Column(
            children: [
              const HomeAppBar(),
              Expanded(
                child: BlocConsumer<FollowingPostBloc, FollowingPostState>(
                  listener: (context, state) {},
                  buildWhen: (previous, current) {
                    return current is FeatchFollowingPostSuccessState ||
                        current is SavePostSuccessState ||
                        current is FeatchFollowingPostLoadingState;
                  },
                  builder: (context, state) {
                    if (state is FeatchFollowingPostLoadingState) {
                      return const ShimmerPostList();
                    } else if (state is FeatchFollowingPostSuccessState) {
                      return RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: ListView.builder(
                          itemCount: state.posts.length + 1,
                          itemBuilder: (context, index) {
                            if (index < state.posts.length) {
                               return PostWidget(
                                postModel: state.posts[index],
                              );
                            }else{
                              
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            
                          },
                        ),
                      );
                    } else {
                      log(state.toString());

                      return const Center(
                        child: Text("No data"),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    log("message");
    // Trigger a re-fetch of the posts
    context.read<FollowingPostBloc>().add(FeatchAllFollowingPostEvent());
  }
}
