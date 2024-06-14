part of 'add_post_bloc.dart';

@immutable
sealed class AddPostState {}

final class AddPostInitial extends AddPostState {}

final class ImageSelectedState extends AddPostState {}

final class PostLoadingState extends AddPostState {}

final class PostSuccessState extends AddPostState {}

final class PostErrorState extends AddPostState {
  final String error;

  PostErrorState({required this.error});
}
