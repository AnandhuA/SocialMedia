import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:social_media/core/colors.dart';

Widget dottedContainer({
  required double height,
  required ThemeData theme,
}) {
  return DottedBorder(
    borderType: BorderType.RRect,
    color: theme.brightness == Brightness.dark
        ? lightModeTextFeildBackground
        : darkModeTextFeildBackground,
    dashPattern: const [8, 4],
    radius: const Radius.circular(
      20,
    ),
    child: SizedBox(
      height: height,
      width: double.infinity,
      child: const Center(
        child: Icon(
          Icons.add_a_photo_outlined,
          size: 40,
          color: greyColor,
        ),
      ),
    ),
  );
}
