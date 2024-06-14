part of 'add_post_bloc.dart';

@immutable
sealed class AddPostEvent {}

final class ImageSeletedEvent extends AddPostEvent {}

final class PostButtonClickEvent extends AddPostEvent {
  final String description;
  final String imagePath;

  PostButtonClickEvent({
    required this.imagePath,
    required this.description,
  });
}
