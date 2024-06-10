import 'package:flutter/material.dart';
import 'package:social_media/core/bacground.dart';

import 'package:social_media/presentation/Profile/widgets/profile_section_one.dart';
import 'package:social_media/presentation/Profile/widgets/profile_section_two.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: ProfileSectionOne(size: size),
                ),
              ];
            },
            body: const ProfileSectionTwo(),
          ),
        ),
      ),
    );
  }
}
