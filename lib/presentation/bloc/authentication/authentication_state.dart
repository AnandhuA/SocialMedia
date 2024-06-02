part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class LoginLoadingState extends AuthenticationState {}

final class LoginErrorState extends AuthenticationState {
  final String error;

  LoginErrorState({required this.error});
}

final class LoginSuccessState extends AuthenticationState {}
