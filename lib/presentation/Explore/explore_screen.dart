import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore"),
      ),
      body: Background(
        child: SafeArea(
          child: Column(children: [
            Expanded(
              child: MasonryGridView.builder(
                  itemCount: dummylistsaved.length,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: dummylistsaved[index],
                        placeholder: (context, url) {
                          return Center(
                            child: imageLoadingShimmer(),
                          );
                        },
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    );
                  }),
            )
          ]),
        ),
      ),
    );
  }
}

List dummylistsaved = [
  "https://media.istockphoto.com/id/1317323736/photo/a-view-up-into-the-trees-direction-sky.jpg?s=612x612&w=0&k=20&c=i4HYO7xhao7CkGy7Zc_8XSNX_iqG0vAwNsrH1ERmw2Q=",
  "https://images.unsplash.com/photo-1583071298704-f4246e5fca2c?fm=jpg&w=3000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://mymodernmet.com/wp/wp-content/uploads/2021/12/kristina-makeeva-eoy-photo-1.jpeg",
  "https://media.istockphoto.com/id/1296344118/photo/beautiful-happy-woman-enjoying-the-warm-sunlight-in-a-tropical-public-park.jpg?s=612x612&w=0&k=20&c=Z0h4uIzZd4cxhkT_CSl9-1wFbnbuqEWYrp5heM9uDuQ=",
  "https://media.istockphoto.com/id/1314559532/photo/relaxed-woman-breathing-fresh-air-in-a-green-forest.jpg?s=612x612&w=0&k=20&c=_LPHSLjVO_ZDMatEHl_62i6RW-6IpnHgjoG3aIDPY2A=",
  "https://www.recordnet.com/gcdn/presto/2021/03/22/NRCD/9d9dd9e4-e84a-402e-ba8f-daa659e6e6c5-PhotoWord_003.JPG?crop=1999,1125,x0,y78&width=1600&height=800&format=pjpg&auto=webp",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMowaBTRsE7_VWl31b8ApWhpFYgLAwjCkrFQ&s",
  "https://st2.depositphotos.com/2001755/5408/i/450/depositphotos_54081723-stock-photo-beautiful-nature-landscape.jpg",
  "https://archive.smashing.media/assets/344dbf88-fdf9-42bb-adb4-46f01eedd629/27282356-b904-4ed6-980a-6f46357baf98/photos-65.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtnvAOajH9gS4C30cRF7rD_voaTAKly2Ntaw&s",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtpIG-rXt0RGqCvBY1S7GdhbRY_l9Nj0mQvA&s",
];
