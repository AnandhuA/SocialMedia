part of 'follow_bloc.dart';

@immutable
sealed class FollowEvent {}

final class FeatchFollwingListEvent extends FollowEvent {}

final class FeatchFollowerListEvent extends FollowEvent {}

final class FollowButtonClickEvent extends FeatchFollowerListEvent {
  final UserModel user;

  FollowButtonClickEvent({required this.user});
}

final class UnFollowButtonClickEvent extends FeatchFollowerListEvent {
  final UserModel user;

  UnFollowButtonClickEvent({required this.user});
  
}
