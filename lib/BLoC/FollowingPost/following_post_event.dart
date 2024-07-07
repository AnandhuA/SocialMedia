part of 'following_post_bloc.dart';

@immutable
sealed class FollowingPostEvent {}

final class FeatchAllFollowingPostEvent extends FollowingPostEvent{}


final class SaveButtonClickEvent extends FollowingPostEvent {
  final PostModel post;

  SaveButtonClickEvent({required this.post});
}

final class UnSaveButtonClickEvent extends FollowingPostEvent {
  final PostModel post;

  UnSaveButtonClickEvent({required this.post});
}
