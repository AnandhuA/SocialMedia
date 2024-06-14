part of 'user_post_bloc.dart';

@immutable
sealed class UserPostState {}

final class UserPostInitial extends UserPostState {}

//-----------Add New Post State----------

final class ImageSelectedState extends UserPostState {}

final class PostLoadingState extends UserPostState {}

final class PostSuccessState extends UserPostState {}

final class PostErrorState extends UserPostState {
  final String error;

  PostErrorState({required this.error});
}

//-------------FeatchPost State-------------

final class FeatchAllMyPostLoadingState extends UserPostState {}

final class FeatchAllMyPostSuccessState extends UserPostState {}

final class FeatchAllMyPostErrorState extends UserPostState {
  final String error;

  FeatchAllMyPostErrorState({required this.error});
}
