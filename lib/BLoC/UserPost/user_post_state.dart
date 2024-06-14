part of 'user_post_bloc.dart';

@immutable
sealed class UserPostState {}

final class UserPostInitial extends UserPostState {}

final class ImageSelectedState extends UserPostState {}

final class PostLoadingState extends UserPostState {}

final class PostSuccessState extends UserPostState {}

final class PostErrorState extends UserPostState {
  final String error;

  PostErrorState({required this.error});
}
