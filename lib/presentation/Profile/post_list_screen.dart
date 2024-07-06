import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/UserPost/user_post_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/presentation/AddAndEditPost/add_post_screen.dart';
import 'package:social_media/presentation/CustomWidgets/confirmation_diloge.dart';
import 'package:social_media/presentation/CustomWidgets/post_widget.dart';

class PostListScreen extends StatelessWidget {
  final List<PostModel> postList;
  const PostListScreen({super.key, required this.postList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  cacheExtent: 1000,
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    return PostWidget(
                         likeOnTap: () {
                        log("like${postList[index].userId.userName}");
                      },
                      postModel: postList[index],
                      moreIcon: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddPostScreen(
                                  editpost: true,
                                  postModel: postList[index],
                                ),
                              ),
                            );
                          } else if (value == 'delete') {
                            confirmationDiloge(
                                context: context,
                                title: "Delete Post",
                                confirmBtn: () {
                                  context.read<UserPostBloc>().add(
                                        DeletePostEvent(
                                          postId: postList[index].id,
                                        ),
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
