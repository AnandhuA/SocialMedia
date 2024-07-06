part of 'like_bloc.dart';

@immutable
sealed class LikeEvent {}

final class UserLikeEvent extends LikeEvent {
  final PostModel post;

  UserLikeEvent({required this.post});
}

final class UserUnLikeEvent extends LikeEvent {
  final PostModel post;

  UserUnLikeEvent({required this.post});
}
