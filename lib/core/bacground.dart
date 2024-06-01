import 'dart:ui';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 250,
            width: 300,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: 250,
            width: 300,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 100,
            sigmaY: 100,
          ),
          child: Container(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: child,
        )
      ],
    );
  }
}
