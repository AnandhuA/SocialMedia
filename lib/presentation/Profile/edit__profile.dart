
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';
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
  @override
  void initState() {
    _nameController.text = widget.userDetails.name ?? "";
    _phoneController.text = widget.userDetails.phone ?? "";
    _bioController.text = widget.userDetails.bio ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppbar(
                title: "Edit Profile",
                backButton: true,
              ),
              ProfileAndCoverPhotoWidget(
                size: size,
                widget: widget,
                coverPhotoAdd: () {
                  bottomSheet(context: context);
                  print(imgFile);
                },
                profilePhotoAdd: () {
                  bottomSheet(context: context);
                  print(imgFile);
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
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Save"),
                    ),
                    constHeight20
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void bottomSheet({
    required BuildContext context,
  }) {
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
                  print("ok");
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () async {
                  imgFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  print("ok");
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
    required this.widget,
    required this.coverPhotoAdd,
    required this.profilePhotoAdd,
  });

  final Size size;
  final EditProfileScreen widget;
  final Function coverPhotoAdd;
  final Function profilePhotoAdd;

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
                  widget.userDetails.backGroundImage,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.userDetails.backGroundImage,
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
                imageUrl: widget.userDetails.profilePic,
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
