part of 'user_post_bloc.dart';

@immutable
sealed class UserPostState {}

final class UserPostInitial extends UserPostState {}

//-----------Add New Post State----------

final class ImageSelectedState extends UserPostState {}

final class AddPostLoadingState extends UserPostState {}

final class AddPostSuccessState extends UserPostState {}

final class EditPostSuccessState extends UserPostState {}

final class AddPostErrorState extends UserPostState {
  final String error;

  AddPostErrorState({required this.error});
}

//-------------FeatchPost State-------------

final class FeatchAllMyPostLoadingState extends UserPostState {}

final class FeatchAllMyPostSuccessState extends UserPostState {
  final List<PostModel> postList;
  final String followersCount;
  final String followingCount;
  final List<SavePostModel> savedPostList;

  FeatchAllMyPostSuccessState({
    required this.postList,
    required this.followersCount,
    required this.followingCount,
    required this.savedPostList,
  });
}

final class FeatchAllMyPostErrorState extends UserPostState {
  final String error;

  FeatchAllMyPostErrorState({required this.error});
}

//---------------Delete post--------------

final class DeletePostLoadingState extends UserPostState {}

final class DeletePostSuccessState extends UserPostState {}

final class DeletePostErrorState extends UserPostState {
  final String error;

  DeletePostErrorState({required this.error});
}

final class FeatchUserPostLoadingState extends UserPostState {}

final class FeatchUserPostSuccessState extends UserPostState {
  final List<PostModel> postList;


  FeatchUserPostSuccessState({required this.postList});
}

final class FeatchUserPostErrorState extends UserPostState {}

