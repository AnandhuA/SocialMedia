import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/AddPost/widgets/dotted_container.dart';
import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Background(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomAppbar(
                  title: "Create",
                ),
                constHeight30,
                const TextField(
                  minLines: 4,
                  maxLines: 10,
                  decoration: InputDecoration(
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
                                  await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text("Gallery"),
                                onTap: () async {
                                  await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: dottedContainer(height: 150, theme: theme),
                ),
                constHeight30,
                ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle().copyWith(
                    backgroundColor: const WidgetStatePropertyAll(
                      secondaryColor,
                    ),
                  ),
                  child: const Text("Post"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
