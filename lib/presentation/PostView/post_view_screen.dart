import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/UserPost/user_post_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/presentation/AddAndEditPost/add_post_screen.dart';
import 'package:social_media/presentation/CustomWidgets/confirmation_diloge.dart';
import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';
import 'package:social_media/presentation/CustomWidgets/custom_snackbar.dart';
import 'package:social_media/presentation/CustomWidgets/post_widget.dart';

class PostViewScreen extends StatelessWidget {
  final PostModel post;
  const PostViewScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocConsumer<UserPostBloc, UserPostState>(
              listener: (context, state) {
                if (state is DeletePostSuccessState) {
                  Navigator.pop(context);
                } else if (state is DeletePostErrorState) {
                  customSnackbar(
                      context: context,
                      message: state.error,
                      color: errorColor);
                } else if (state is DeletePostLoadingState) {}
              },
              builder: (context, state) {
                return Column(
                  children: [
                    const CustomAppbar(
                      title: "",
                      backButton: true,
                    ),
                    PostWidget(
                      likeOnTap: () {
                        log("like${post.userId.userName}");
                      },
                      postModel: post,
                      moreIcon: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddPostScreen(
                                  editpost: true,
                                  postModel: post,
                                ),
                              ),
                            );
                          } else if (value == 'delete') {
                            confirmationDiloge(
                                context: context,
                                title: "Delete Post",
                                confirmBtn: () {
                                  context.read<UserPostBloc>().add(
                                        DeletePostEvent(postId: post.id),
                                      );
                                  Navigator.pop(context);
                                },
                                content: "Do you want to delete this post?");
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            const PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ];
                        },
                        icon: const Icon(
                          Icons.more_vert_outlined,
                        ),
                      ),
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
