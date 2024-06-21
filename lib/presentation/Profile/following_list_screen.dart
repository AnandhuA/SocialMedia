import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/CustomWidgets/custom_appbar.dart';
import 'package:social_media/presentation/CustomWidgets/custom_button.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';

class FollowingListScreen extends StatelessWidget {
  const FollowingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const CustomAppbar(
                  title: "",
                  backButton: true,
                ),
                const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                  ),
                ),
                constHeight10,
                followingListLoading(iteamCount: 10)
                // Expanded(
                //   child: ListView.separated(
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         leading: CircleAvatar(
                //           radius: 30,
                //         ),
                //         title: Text("Name"),
                //         trailing: CustomButton(
                //           title: "Remove",
                //           minWidth: 15,
                //           color: theme.brightness == Brightness.dark
                //               ? darkModeCustomButtonBG
                //               : lightModeCustomButtonBG,
                //           onTap: () {
                //             log("remove");
                //           },
                //         ),
                //       );
                //     },
                //     separatorBuilder: (context, index) => constHeight20,
                //     itemCount: 23,
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
