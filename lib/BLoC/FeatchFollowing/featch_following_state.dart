part of 'featch_following_bloc.dart';

@immutable
sealed class FeatchFollowingState {}

final class FeatchFollowingInitial extends FeatchFollowingState {}

final class FeatchFollowingLoadingState extends FeatchFollowingState {}

final class FeatchFollowingSuccessState extends FeatchFollowingState {
  final List<UserModel> follwingList;

  FeatchFollowingSuccessState({required this.follwingList});
}

final class FeatchFollowerSuccessState extends FeatchFollowingState {
  final List<UserModel> followerList;

  FeatchFollowerSuccessState({required this.followerList});
}

final class FeatchFollowingErrorState extends FeatchFollowingState {
  final String error;

  FeatchFollowingErrorState({required this.error});
}
