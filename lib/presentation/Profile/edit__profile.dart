import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:social_media/BLoC/ImageUpload/image_upload_bloc.dart';
import 'package:social_media/BLoC/UserDetails/user_details_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';
import 'package:social_media/presentation/CustomWidgets/custom_snackbar.dart';
import 'package:social_media/presentation/CustomWidgets/loading_button.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel userDetails;
  const EditProfileScreen({super.key, required this.userDetails});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  XFile? imgFile;
  late String coverPhoto;
  late String profilePhoto;
  @override
  void initState() {
    _nameController.text = widget.userDetails.name ?? "";
    _phoneController.text = widget.userDetails.phone ?? "";
    _bioController.text = widget.userDetails.bio ?? "";
    coverPhoto = widget.userDetails.backGroundImage;
    profilePhoto = widget.userDetails.profilePic;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: BlocListener<UserDetailsBloc, UserDetailsState>(
            listener: (context, state) {
              if (state is EditUserDetailsSuccessState) {
                customSnackbar(
                    context: context, message: "Success", color: successColor);
                Navigator.pop(context);
              } else if (state is EditUserDetailsErrorState) {
                customSnackbar(
                    context: context, message: state.error, color: errorColor);
              }
            },
            child: Column(
              children: [
                const CustomAppbar(
                  title: "Edit Profile",
                  backButton: true,
                ),
                BlocConsumer<ImageUploadBloc, ImageUploadState>(
                  listener: (context, state) {
                    if (state is ImageUploadSuccessState) {
                      state.coverPhoto
                          ? coverPhoto = state.imgeUrl
                          : profilePhoto = state.imgeUrl;
                    } else if (state is ImageUploadErrorState) {
                      customSnackbar(
                          context: context,
                          message: "Image upload error",
                          color: errorColor);
                    }
                    if (state is ImageUploadLoadingState) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    } else {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  builder: (context, state) {
                    return ProfileAndCoverPhotoWidget(
                      size: size,
                      profilePhoto: profilePhoto,
                      coverPhoto: coverPhoto,
                      coverPhotoAdd: () {
                        bottomSheet(context: context, coverPhoto: true);
                      },
                      profilePhotoAdd: () {
                        bottomSheet(context: context, coverPhoto: false);
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "  Name",
                        style: theme.textTheme.titleLarge,
                      ),
                      constHeight10,
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(hintText: "Name"),
                        style: theme.textTheme.titleLarge,
                      ),
                      constHeight10,
                      Text(
                        "  Phone",
                        style: theme.textTheme.titleLarge,
                      ),
                      constHeight10,
                      TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(hintText: "Phone"),
                        style: theme.textTheme.titleLarge,
                      ),
                      constHeight10,
                      Text(
                        "  Bio",
                        style: theme.textTheme.titleLarge,
                      ),
                      constHeight10,
                      TextField(
                        controller: _bioController,
                        minLines: 4,
                        maxLines: 10,
                        decoration: const InputDecoration(hintText: "Bio"),
                        style: theme.textTheme.titleLarge,
                      ),
                      constHeight40,
                      BlocBuilder<UserDetailsBloc, UserDetailsState>(
                        builder: (context, state) {
                          return state is EditUserDetailsLoadingState
                              ? const LoadingButton()
                              : ElevatedButton(
                                  onPressed: () {
                                    context.read<UserDetailsBloc>().add(
                                          EditUserDetailsEvent(
                                            name: _nameController.text,
                                            bio: _bioController.text,
                                            profilePhoto: profilePhoto,
                                            coverPhoto: coverPhoto,
                                          ),
                                        );
                                  },
                                  child: const Text("Save"),
                                );
                        },
                      ),
                      constHeight20
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void bottomSheet({required BuildContext context, required bool coverPhoto}) {
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
                  imgFile =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (imgFile != null) {
                    Navigator.pop(context);
                    context.read<ImageUploadBloc>().add(
                          EditProfileImageUploadEvent(
                            imagePath: imgFile!.path,
                            coverPhoto: coverPhoto,
                          ),
                        );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () async {
                  imgFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (imgFile != null) {
                    Navigator.pop(context);
                    context.read<ImageUploadBloc>().add(
                          EditProfileImageUploadEvent(
                            imagePath: imgFile!.path,
                            coverPhoto: coverPhoto,
                          ),
                        );
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}

class ProfileAndCoverPhotoWidget extends StatelessWidget {
  const ProfileAndCoverPhotoWidget({
    super.key,
    required this.size,
    required this.coverPhotoAdd,
    required this.profilePhotoAdd,
    required this.profilePhoto,
    required this.coverPhoto,
  });

  final Size size;
  final Function coverPhotoAdd;
  final Function profilePhotoAdd;
  final String profilePhoto;
  final String coverPhoto;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: size.height * 0.3,
          width: double.infinity,
        ),
        Positioned(
          child: Container(
            width: double.infinity,
            height: size.height * 0.23,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  coverPhoto,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: coverPhoto,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Center(
                  child: imageLoadingShimmer(),
                );
              },
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: whiteColor,
            radius: 65,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: transparentColor,
              child: CachedNetworkImage(
                imageUrl: profilePhoto,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 60,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: imageLoadingShimmer(),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: CircleAvatar(
            child: IconButton(
              onPressed: () => coverPhotoAdd(),
              icon: const Icon(Icons.add_a_photo),
            ),
          ),
        ),
        Positioned(
          left: 90,
          right: 0,
          bottom: 0,
          child: CircleAvatar(
            radius: 19,
            child: IconButton(
              onPressed: () => profilePhotoAdd(),
              icon: const Icon(Icons.add),
            ),
          ),
        )
      ],
    );
  }
}
