part of 'user_details_bloc.dart';

@immutable
sealed class UserDetailsEvent {}

final class FeatchUserDetailsEvent extends UserDetailsEvent {}

final class EditUserDetailsEvent extends UserDetailsEvent {
  final String name;
  final String bio;
  final String profilePhoto;
  final String coverPhoto;
  

  EditUserDetailsEvent({
    required this.name,
    required this.bio,
    required this.profilePhoto,
    required this.coverPhoto,
  });
}
