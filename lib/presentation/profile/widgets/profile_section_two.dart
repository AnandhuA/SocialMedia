import 'package:flutter/material.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/profile/widgets/profile_info_button.dart';

class ProfileSectionTwo extends StatelessWidget {
  const ProfileSectionTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          constHeight30,
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileInfoButton(
                count: "03",
                title: "Posts",
              ),
              ProfileInfoButton(
                count: "234",
                title: "Follower",
              ),
              ProfileInfoButton(
                count: "302",
                title: "Following",
              )
            ],
          ),
          constHeight30,
          const TabBar(
            tabs: [
              Tab(text: 'Posts'),
              Tab(text: 'Saved'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "data",
                        style: theme.textTheme.labelLarge,
                      ),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "next",
                        style: theme.textTheme.labelLarge,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
