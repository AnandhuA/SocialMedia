part of 'user_details_bloc.dart';

@immutable
sealed class UserDetailsState {}

final class UserDetailsInitial extends UserDetailsState {}

final class FeatchUserDetailsLoadingState extends UserDetailsState {}

final class FeatchUserDetailsSuccessState extends UserDetailsState {
  final UserModel userDetails;

  FeatchUserDetailsSuccessState({required this.userDetails});
}

final class FeatchUserDetailsErrorState extends UserDetailsState {
  final String error;

  FeatchUserDetailsErrorState({required this.error});
}
