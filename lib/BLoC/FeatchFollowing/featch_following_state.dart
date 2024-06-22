part of 'featch_following_bloc.dart';

@immutable
sealed class FeatchFollowingState {}

final class FeatchFollowingInitial extends FeatchFollowingState {}


final class FeatchFollowingLoadingState extends FeatchFollowingState {}

final class FeatchFollowingSuccessState extends FeatchFollowingState {}

final class FeatchFollowingErrorState extends FeatchFollowingState {
  final String error;

  FeatchFollowingErrorState({required this.error});
}
