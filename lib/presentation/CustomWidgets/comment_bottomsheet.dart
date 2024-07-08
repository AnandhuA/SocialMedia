import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/FollowingPost/following_post_bloc.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/presentation/CustomWidgets/confirmation_diloge.dart';

Future<dynamic> commentBottomSheet(
    {required BuildContext context,
    required TextEditingController commentController,
    // required GlobalKey<FormState> formkey,
    required PostModel post,
    required String id,
    required String profilePic}) {
  final theme = Theme.of(context);

  return showModalBottomSheet(
    backgroundColor:
        theme.brightness == Brightness.dark ? surfaceDark : surfaceLight,
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: CachedNetworkImageProvider(
                  profilePic,
                ),
              ),
              constWidth10,
              Expanded(
                child: Form(
                  // key: formkey,
                  child: TextFormField(
                    controller: commentController,
                    style: TextStyle(
                        color: theme.brightness == Brightness.dark
                            ? whiteColor
                            : blackColor),
                    decoration: InputDecoration(
                      hintText: 'Write comment',
                      hintStyle: const TextStyle(fontSize: 14),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_circle_rounded,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Write comment';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              )
            ],
          ),
          const Divider(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.415,
            child: BlocBuilder<FollowingPostBloc, FollowingPostState>(
              builder: (context, state) {
                if (state is FeatchCommentsLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FeatchCommentsSuccessState) {
                  return ListView.separated(
                    itemCount: state.comments.length,
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: CachedNetworkImageProvider(
                              state.comments[index].userId.profilePic,
                            ),
                          ),
                          constWidth10,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  maxLines: 5,
                                  state.comments[index].userName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: theme.brightness == Brightness.dark
                                        ? whiteColor
                                        : blackColor,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  maxLines: 100,
                                  state.comments[index].content,
                                  style: TextStyle(
                                    fontSize: 15,
                                    overflow: TextOverflow.ellipsis,
                                    color: theme.brightness == Brightness.dark
                                        ? whiteColor
                                        : blackColor,
                                  ),
                                ),

                                // Text(
                                //   state.comments[index].createdAt.toString(),
                                //   style: TextStyle(fontSize: 12),
                                // ),
                              ],
                            ),
                          ),
                          constWidth10,
                          // GestureDetector(
                          //   onTap: () {
                          //     confirmationDiloge(
                          //         context: context,
                          //         title: "Delete",
                          //         confirmBtn: () {
                          //           Navigator.pop(context);
                          //         },
                          //         content:
                          //             "Are you sure want to Delete comment ?");
                          //   },
                          //   child: const Icon(
                          //     Icons.delete_rounded,
                          //     size: 22,
                          //   ),
                          // )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  );
                }
                return ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 18,
                          ),
                          constWidth10,
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  maxLines: 5,
                                  "  comment.user.userName,",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  maxLines: 100,
                                  "comment.content,",
                                  style: TextStyle(
                                      fontSize: 15,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  "",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          constWidth10,
                          GestureDetector(
                            onTap: () {
                              confirmationDiloge(
                                  context: context,
                                  title: "Delete",
                                  confirmBtn: () {
                                    Navigator.pop(context);
                                  },
                                  content:
                                      "Are you sure want to Delete comment ?");
                            },
                            child: const Icon(
                              Icons.delete_rounded,
                              size: 22,
                            ),
                          )
                        ],
                      );
                    });
              },
            ),
          ),
        ],
      ),
    ),
  );
}
