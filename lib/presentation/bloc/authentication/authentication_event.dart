part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class LoginButtonClickEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginButtonClickEvent({
    required this.email,
    required this.password,
  });
}

class SignupButtonClickEvent extends AuthenticationEvent {}
