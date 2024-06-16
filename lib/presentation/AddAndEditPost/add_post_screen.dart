import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/BLoC/UserPost/user_post_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/presentation/AddAndEditPost/widgets/dotted_container.dart';
import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';
import 'package:social_media/presentation/CustomWidgets/custom_snackbar.dart';
import 'package:social_media/presentation/CustomWidgets/loading_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({
    super.key,
    this.editpost = false,
    this.postModel,
  });
  final bool editpost;
  final PostModel? postModel;

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  XFile? imgFile;
  String? postImage;

  final TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    if (widget.editpost && widget.postModel != null) {
      _descriptionController.text = widget.postModel!.description;
      postImage = widget.postModel!.image;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Background(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: BlocConsumer<UserPostBloc, UserPostState>(
              listener: (context, state) {
                if (state is AddPostErrorState) {
                  customSnackbar(
                    context: context,
                    message: state.error,
                    color: errorColor,
                  );
                } else if (state is AddPostSuccessState) {
                  customSnackbar(
                    context: context,
                    message: "Post add Success",
                    color: successColor,
                  );
                  _descriptionController.clear();
                  imgFile = null;
                } else if (state is EditPostSuccessState) {
                  customSnackbar(
                    context: context,
                    message: "Post Edited",
                    color: successColor,
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    CustomAppbar(
                      title: widget.editpost ? "Edit Post" : "Create Post",
                      backButton: widget.editpost,
                    ),
                    constHeight30,
                    TextField(
                      controller: _descriptionController,
                      minLines: 4,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        hintText: "What would you like to say?",
                      ),
                      style: theme.textTheme.titleLarge,
                    ),
                    constHeight30,
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 150,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.photo_camera),
                                    title: const Text("Camera"),
                                    onTap: () async {
                                      imgFile = await ImagePicker().pickImage(
                                          source: ImageSource.camera);
                                      Navigator.pop(context);
                                      context
                                          .read<UserPostBloc>()
                                          .add(ImageSeletedEvent());
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text("Gallery"),
                                    onTap: () async {
                                      imgFile = await ImagePicker().pickImage(
                                          source: ImageSource.gallery);
                                      Navigator.pop(context);
                                      context
                                          .read<UserPostBloc>()
                                          .add(ImageSeletedEvent());
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: imgFile == null
                          ? postImage != null
                              ? SizedBox(
                                  height: 200,
                                  child: Image.network(
                                    postImage!,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : dottedContainer(
                                  height: 150,
                                  theme: theme,
                                )
                          : SizedBox(
                              height: 200,
                              child: Image.file(
                                File(imgFile!.path),
                                fit: BoxFit.fill,
                              ),
                            ),
                    ),
                    constHeight30,
                    state is AddPostLoadingState
                        ? const LoadingButton(
                            color: secondaryColor,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (imgFile != null || postImage != null) {
                                widget.editpost
                                    ? context.read<UserPostBloc>().add(
                                          EditPostButtonClickEvent(
                                              description:
                                                  _descriptionController.text,
                                              imageLink: postImage,
                                              imageFile: imgFile,
                                              postId: widget.postModel!.id),
                                        )
                                    : context.read<UserPostBloc>().add(
                                          PostButtonClickEvent(
                                            imagePath: imgFile!.path,
                                            description:
                                                _descriptionController.text,
                                          ),
                                        );
                              } else {
                                customSnackbar(
                                  context: context,
                                  message: "Select Photo",
                                  color: errorColor,
                                );
                              }
                            },
                            style: const ButtonStyle().copyWith(
                              backgroundColor: const WidgetStatePropertyAll(
                                secondaryColor,
                              ),
                            ),
                            child: const Text("Post"),
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
