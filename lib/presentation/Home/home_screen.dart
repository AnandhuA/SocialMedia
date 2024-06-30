import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/FollowingPost/following_post_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/Home/widgets/home_app_bar.dart';
import 'package:social_media/presentation/CustomWidgets/post_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    // final theme = Theme.of(context);
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Column(
            children: [
              const HomeAppBar(),
              Expanded(
                child: BlocBuilder<FollowingPostBloc, FollowingPostState>(
                  builder: (context, state) {
                    if (state is FeatchFollowingPostLoadingState) {
                      return const ShimmerPostList();
                    } else if (state is FeatchFollowingPostSuccessState) {
                      return ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return PostWidget(
                            postUrl: state.posts[index].image,
                            description: state.posts[index].description,
                            userName: state.posts[index].userId.userName,
                            likeCount:
                                state.posts[index].likes.length.toString(),
                            commentCount: "",
                            time: timeago.format(state.posts[index].createdAt),
                            profilePic: state.posts[index].userId.profilePic,
                          );
                        },
                      );
                    }
                    return ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return const PostWidget(
                          postUrl:
                              "https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg",
                          description: "Welcome",
                          userName: "Anandhu",
                          likeCount: "14",
                          commentCount: "10",
                          time: "20 min ago",
                          profilePic:
                              "https://res.cloudinary.com/di9yf5j0d/image/upload/v1695795823/om0qyogv6dejgjseakej.png",
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
