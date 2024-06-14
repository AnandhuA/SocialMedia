part of 'user_post_bloc.dart';

@immutable
sealed class UserPostEvent {}

final class ImageSeletedEvent extends UserPostEvent {}

final class PostButtonClickEvent extends UserPostEvent {
  final String description;
  final String imagePath;

  PostButtonClickEvent({
    required this.imagePath,
    required this.description,
  });
}
