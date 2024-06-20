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
    baseColor: greyColor300,
    highlightColor: greyColor100,
    child: Column(
      children: [
        Container(
          height: 150,
          color: whiteColor,
        ),
        const SizedBox(height: 10),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: whiteColor,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: whiteColor,
              ),
            ),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: whiteColor,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget imageLoadingShimmer() {
  return Shimmer.fromColors(
    baseColor: greyColor300,
    highlightColor: greyColor100,
    child: Container(
      color: whiteColor,
    ),
  );
}
