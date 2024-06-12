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
      width: 80,
      height: 80,
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
            bottom: 12,
            right: 0,
            left: 21,
            top: 0,
            child: Center(
              child: CircleAvatar(
                radius: 15,
                child: InkWell(
                  onTap: () => onTap(),
                  child: child,
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            top: 10,
            left: 45,
            right: 0,
            child: Center(
              child: CircleAvatar(
                radius: 4,
                backgroundColor: onlineColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
