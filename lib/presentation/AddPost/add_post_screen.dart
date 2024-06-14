import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/BLoC/AddPost/add_post_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/AddPost/widgets/dotted_container.dart';
import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';
import 'package:social_media/presentation/CustomWidgets/custom_snackbar.dart';
import 'package:social_media/presentation/CustomWidgets/loading_button.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});
  XFile? imgFile;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Background(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: BlocConsumer<AddPostBloc, AddPostState>(
              listener: (context, state) {
                if (state is PostErrorState) {
                  customSnackbar(
                    context: context,
                    message: state.error,
                    color: errorColor,
                  );
                } else if (state is PostSuccessState) {
                  customSnackbar(
                    context: context,
                    message: "Post add Success",
                    color: successColor,
                  );
                  _descriptionController.clear();
                  imgFile = null;
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    const CustomAppbar(
                      title: "Create",
                    ),
                    constHeight30,
                    TextField(
                      controller: _descriptionController,
                      minLines: 4,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        hintText: "What would you like to say?",
                      ),
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
                                          .read<AddPostBloc>()
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
                                          .read<AddPostBloc>()
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
                          ? dottedContainer(height: 150, theme: theme)
                          : SizedBox(
                              height: 200,
                              child: Image.file(
                                File(imgFile!.path),
                                fit: BoxFit.fill,
                              ),
                            ),
                    ),
                    constHeight30,
                    state is PostLoadingState
                        ? const LoadingButton(
                            color: secondaryColor,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (imgFile != null) {
                                context.read<AddPostBloc>().add(
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
