import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/BLoC/Suggestion/suggestion_bloc_bloc.dart';
import 'package:social_media/core/bacground.dart';
import 'package:social_media/core/size.dart';
import 'package:social_media/presentation/CustomWidgets/shimmer_widgets.dart';
import 'package:social_media/presentation/Suggestion/widgets/suggestion_tile.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  @override
  void initState() {
    context.read<SuggestionBloc>().add(SuggestionListFeatchingEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const crossAxisCount = 2;
    final childAspectRatio = screenWidth / (screenWidth / crossAxisCount * 2.3);
    final theme = Theme.of(context);
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 10,
              top: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "People you may know",
                  style: theme.textTheme.titleLarge,
                ),
                constHeight20,
                Expanded(
                  child: BlocBuilder<SuggestionBloc, SuggestionBlocState>(
                    builder: (context, state) {
                      if (state is SuggestionLoadingState) {
                        return GridView.builder(
                          itemCount: 41,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 5,
                            childAspectRatio: childAspectRatio,
                          ),
                          itemBuilder: (context, index) {
                            return suggestionShimmer();
                          },
                        );
                      } else if (state is SuggestionSuccessState) {
                        return GridView.builder(
                          itemCount: state.suggestionModelList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 5,
                            childAspectRatio: childAspectRatio,
                          ),
                          itemBuilder: (context, index) {
                            return SuggestionTile(
                              suggessionUser: state.suggestionModelList[index],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("Error"),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
