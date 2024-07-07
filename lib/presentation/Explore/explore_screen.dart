import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/Explore/explore_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/Explore/widgets/explore_post_widget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    context.read<ExploreBloc>().add(FeatchExplorePostEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore"),
      ),
      body: Background(
        child: SafeArea(
          child: BlocConsumer<ExploreBloc, ExploreState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: BlocBuilder<ExploreBloc, ExploreState>(
                      builder: (context, state) {
                        if (state is FeatchExplorePostLoadingState) {
                          return const Center(
                            child: ShimmerExploreView(),
                          );
                        } else if (state is FeatchExplorePostSuccessState) {
                          return ExplorePostWidget(
                            postList: state.posts,
                          );
                        }
                        return const Center(
                          child: Text("Error"),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
