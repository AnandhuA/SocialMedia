part of 'follow_bloc.dart';

@immutable
sealed class FollowState {}

final class FeatchFollowingInitial extends FollowState {}

//-----------featchFollowing----------------

final class FeatchFollowingLoadingState extends FollowState {}

final class FeatchFollowingSuccessState extends FollowState {
  final List<UserModel> follwingList;

  FeatchFollowingSuccessState({required this.follwingList});
}

final class FeatchFollowerSuccessState extends FollowState {
  final List<UserModel> followerList;

  FeatchFollowerSuccessState({required this.followerList});
}

final class FeatchFollowingErrorState extends FollowState {
  final String error;

  FeatchFollowingErrorState({required this.error});
}

//---------------follow and unfollow user ------------

final class FollowUserLoadingState extends FollowState {}

final class FollowUserSuccessState extends FollowState {
  final List connectionUserId;
  final bool isFollowing;

  FollowUserSuccessState(
      {required this.connectionUserId, required this.isFollowing});
}

final class FollowUserErrorState extends FollowState {
  final String error;

  FollowUserErrorState({required this.error});
}

final class UnFollowUserLoadingState extends FollowState {}

final class UnFollowUserSuccessState extends FollowState {
  final bool isFollowing;

  UnFollowUserSuccessState({required this.isFollowing});
}

final class UnFollowUserErrorState extends FollowState {
  final String error;

  UnFollowUserErrorState({required this.error});
}

final class IsFollowingLoadingState extends FollowState {}

final class IsFollowingSuccessState extends FollowState {
  final bool isFollowing;

  IsFollowingSuccessState({required this.isFollowing});
}

final class IsFollowingErrorState extends FollowState {
  final String error;

  IsFollowingErrorState({required this.error});
}
