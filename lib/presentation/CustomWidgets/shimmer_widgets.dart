import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/core/colors.dart';

Widget postGridShimmerEffect({required int itemCount}) {
  return Center(
    child: Shimmer.fromColors(
      baseColor: greyColor,
      highlightColor: greyColor200,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            width: 50,
            color: whiteColor,
          );
        },
      ),
    ),
  );
}
