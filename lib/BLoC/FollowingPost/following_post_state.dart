part of 'following_post_bloc.dart';

@immutable
sealed class FollowingPostState {}

final class FollowingPostInitial extends FollowingPostState {}

final class FeatchFollowingPostLoadingState extends FollowingPostState {}

final class FeatchFollowingPostSuccessState extends FollowingPostState {
  final List<PostModel> posts;

  FeatchFollowingPostSuccessState({required this.posts});
}

final class FeatchFollowingPostErrorState extends FollowingPostState {
  final String error;

  FeatchFollowingPostErrorState({required this.error});
}
