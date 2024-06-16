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

Widget profileLoadingShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      children: [
        Container(
          height: 200,
          color: Colors.white,
        ),
        const SizedBox(height: 20),
        Container(
          height: 20,
          width: 150,
          color: Colors.white,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 50,
              width: 150,
              color: Colors.white,
            ),
            Container(
              height: 50,
              width: 150,
              color: Colors.white,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget imageLoadingShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      color: Colors.white,
    ),
  );
}
