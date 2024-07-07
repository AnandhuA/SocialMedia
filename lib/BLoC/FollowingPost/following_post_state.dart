part of 'following_post_bloc.dart';

@immutable
sealed class FollowingPostState {}

final class FollowingPostInitial extends FollowingPostState {}

//---------------fetch post state---------------

final class FeatchFollowingPostLoadingState extends FollowingPostState {}

final class FeatchFollowingPostSuccessState extends FollowingPostState {
  final List<PostModel> posts;

  FeatchFollowingPostSuccessState({required this.posts});
}

final class FeatchFollowingPostErrorState extends FollowingPostState {
  final String error;

  FeatchFollowingPostErrorState({required this.error});
}


//---------------save post state---------------

final class SavePostLoadingState extends FollowingPostState {}
final class UnSavePostLoadingState extends FollowingPostState {}

final class SavePostSuccessState extends FollowingPostState {
  final String postId;

  SavePostSuccessState({required this.postId});
}

final class SavePostErrorState extends FollowingPostState {
  final String error;

  SavePostErrorState({required this.error});
}

//---------------like post state---------------


final class LikeLoadingState extends FollowingPostState {}

final class LikeSuccessState extends FollowingPostState {}

final class LikeErrorState extends FollowingPostState {}
