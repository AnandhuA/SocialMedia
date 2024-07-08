part of 'follow_bloc.dart';

@immutable
sealed class FollowEvent {}

final class FeatchFollwingListEvent extends FollowEvent {}

final class FeatchFollowerListEvent extends FollowEvent {}

final class FollowButtonClickEvent extends FollowEvent {
  final UserModel user;

  FollowButtonClickEvent({required this.user});
}

final class UnFollowButtonClickEvent extends FollowEvent {
  final UserModel user;

  UnFollowButtonClickEvent({required this.user});
}

final class IsfollowingEvent extends FollowEvent {
  final UserModel user;

  IsfollowingEvent({required this.user});
}
