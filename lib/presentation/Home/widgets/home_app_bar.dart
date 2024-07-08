import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/UserDetails/user_details_bloc.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/main.dart';
import 'package:social_media/presentation/Home/widgets/profile_icon_widget.dart';
import 'package:social_media/presentation/Profile/profile_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      buildWhen: (previous, current) {
        return current is EditUserDetailsSuccessState;
      },
      builder: (context, state) {
        return Row(
          children: [
            constWidth20,
            Text(
              "Hi,$userName",
              style: theme.textTheme.headlineMedium,
            ),
            const Spacer(),
            ProfileIconWidget(
              child: CircleAvatar(
                backgroundColor: transparentColor,
                backgroundImage: CachedNetworkImageProvider(
                  userProfilePic,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ));
              },
            )
          ],
        );
      },
    );
  }
}
