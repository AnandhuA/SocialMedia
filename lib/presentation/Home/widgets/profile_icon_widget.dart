import 'package:flutter/material.dart';
import 'package:social_media/core/colors.dart';

class ProfileIconWidget extends StatelessWidget {
  final Widget child;
  final Function onTap;
  const ProfileIconWidget({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            theme.brightness == Brightness.dark
                ? "assets/images/profilePicBgDark.png"
                : "assets/images/profilepicBgLight.png",
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 18,
            right: 0,
            left: 32,
            top: 0,
            child: Center(
              child: CircleAvatar(
                radius: 20,
                child: InkWell(
                  onTap:()=> onTap(),
                  child: child,
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            top: 10,
            left: 60,
            right: 0,
            child: Center(
              child: CircleAvatar(
                radius: 5,
                backgroundColor: onlineColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
