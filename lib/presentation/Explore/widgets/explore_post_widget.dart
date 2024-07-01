import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';

class ExplorePostWidget extends StatelessWidget {
  final List<PostModel> postList;
  const ExplorePostWidget({super.key, required this.postList});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      itemCount: postList.length,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      cacheExtent: 10000,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            imageUrl: postList[index].image,
            placeholder: (context, url) {
              return Center(
                child: imageLoadingShimmer(),
              );
            },
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
      },
    );
  }
}
