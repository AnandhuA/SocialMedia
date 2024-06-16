part of 'user_post_bloc.dart';

@immutable
sealed class UserPostEvent {}

//-----------Add new Post Event------------

final class ImageSeletedEvent extends UserPostEvent {}

final class PostButtonClickEvent extends UserPostEvent {
  final String description;
  final String imagePath;

  PostButtonClickEvent({
    required this.imagePath,
    required this.description,
  });
}
//-----------Edit Post Event-----------

final class EditPostButtonClickEvent extends UserPostEvent {
  final String description;
  final XFile? imageFile;
  final String? imageLink;
  final String postId;

  EditPostButtonClickEvent(
      {required this.description,
      required this.imageFile,
      required this.imageLink,
      required this.postId});
}
//-------------Featch my all posts event---------

final class FeatchAllMyPostEvent extends UserPostEvent {}

//---------------Delete post---------
final class DeletePostEvent extends UserPostEvent {
  final String postId;

  DeletePostEvent({required this.postId});
}
