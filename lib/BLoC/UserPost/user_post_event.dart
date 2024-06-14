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


//-------------Featch my all posts event---------


final class FeatchAllMyPostEvent extends UserPostEvent{}