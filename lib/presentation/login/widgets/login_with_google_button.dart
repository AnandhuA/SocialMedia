import 'package:flutter/material.dart';
import 'package:social_media/core/colors.dart';

class LoginWithGoogleButton extends StatelessWidget {
  const LoginWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " LogIn with",
          style: theme.textTheme.labelLarge,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 45,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: theme.colorScheme.outline),
            color: customButtonBackground,
          ),
          child: Center(
            child: Image.asset(
              theme.brightness == Brightness.dark
                  ? "assets/images/googlelogoLight.png"
                  : "assets/images/googlelogoDark.png",
            ),
          ),
        ),
      ],
    );
  }
}
