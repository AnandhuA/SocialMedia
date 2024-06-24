import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/size.dart';

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

Widget followingListLoading({required int iteamCount}) {
  return Expanded(
    child: ListView.separated(
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: greyColor,
          highlightColor: greyColor200,
          child: ListTile(
            leading: const CircleAvatar(
              radius: 30,
              backgroundColor: whiteColor,
            ),
            title: Row(
              children: [
                Container(
                  width: 80,
                  height: 12,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
            trailing: Container(
              width: 80,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: whiteColor,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => constHeight20,
      itemCount: iteamCount,
    ),
  );
}

Widget profileLoadingShimmer() {
  return Shimmer.fromColors(
    baseColor: greyColor,
    highlightColor: greyColor200,
    child: Column(
      children: [
        Container(
          height: 200,
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
    baseColor: greyColor,
    highlightColor: greyColor200,
    child: Container(
      color: whiteColor,
    ),
  );
}

Widget suggestionShimmer() {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: greyColor),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        SizedBox(
          height: 135,
          child: Stack(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  color: greyColor, // Placeholder color
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: greyColor300,
                    highlightColor: greyColor100,
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                right: 0,
                left: 0,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: greyColor, // Placeholder color
                  child: Shimmer.fromColors(
                    baseColor: greyColor300,
                    highlightColor: greyColor100,
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Shimmer.fromColors(
          baseColor: greyColor300,
          highlightColor: greyColor100,
          child: Container(
            width: 100,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: whiteColor,
            ),
            margin: const EdgeInsets.only(top: 10),
          ),
        ),
        constHeight20,
        Shimmer.fromColors(
          baseColor: greyColor300,
          highlightColor: greyColor100,
          child: Container(
            height: 30,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: whiteColor,
            ),
            margin: const EdgeInsets.only(bottom: 10),
          ),
        ),
        constHeight10,
      ],
    ),
  );
}
