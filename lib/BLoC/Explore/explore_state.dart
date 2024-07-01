part of 'explore_bloc.dart';

@immutable
sealed class ExploreState {}

final class ExploreInitial extends ExploreState {}

final class FeatchExplorePostLoadingState extends ExploreState {}

final class FeatchExplorePostSuccessState extends ExploreState {
  final List<PostModel> posts;

  FeatchExplorePostSuccessState({required this.posts});

}

final class FeatchExplorePostErrorState extends ExploreState {
  final String error;

  FeatchExplorePostErrorState({required this.error});
}
