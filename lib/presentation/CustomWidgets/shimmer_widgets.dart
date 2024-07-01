import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
          height: 120,
          child: Stack(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  color: greyColor,
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
                  radius: 45,
                  backgroundColor: greyColor,
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
        const Spacer(),
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
        const Spacer(),
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
        const Spacer(),
      ],
    ),
  );
}

class ShimmerPostList extends StatelessWidget {
  const ShimmerPostList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  shimmerCircle(50),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmerRectangle(width: 100, height: 20),
                      const SizedBox(height: 5),
                      shimmerRectangle(width: 60, height: 15),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 10),
              shimmerRectangle(width: double.infinity, height: 20),
              const SizedBox(height: 10),
              shimmerRectangle(width: double.infinity, height: 200),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    shimmerIconButton(icon: Icons.favorite),
                    shimmerIconButton(icon: Icons.message),
                    shimmerIconButton(icon: Icons.save),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget shimmerCircle(double size) {
    return Shimmer.fromColors(
      baseColor: greyColor300,
      highlightColor: greyColor100,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: whiteColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget shimmerRectangle({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: greyColor300,
      highlightColor: greyColor100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget shimmerIconButton({required IconData icon}) {
    return Shimmer.fromColors(
      baseColor: greyColor300,
      highlightColor: greyColor100,
      child: Icon(icon, color: greyColor),
    );
  }
}

class ShimmerExploreView extends StatelessWidget {
  const ShimmerExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 3,
        mainAxisSpacing: 1,
        pattern: [
          const QuiltedGridTile(2, 2),
          const QuiltedGridTile(2, 1),
          const QuiltedGridTile(1, 1),
          const QuiltedGridTile(1, 1),
          const QuiltedGridTile(1, 1)
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: 20,
        (context, index) {
          return gridItemShimmer();
        },
      ),
    );
  }
}

Widget gridItemShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      margin: const EdgeInsets.all(2),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}
