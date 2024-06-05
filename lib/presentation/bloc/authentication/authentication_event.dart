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

class SignupButtonClickEvent extends AuthenticationEvent {
  final UserModel userModel;

  SignupButtonClickEvent({
    required this.userModel
  });
}

class VerificationButtonClickEvent extends AuthenticationEvent {
  final String email;
  final String otp;

  VerificationButtonClickEvent({
    required this.email,
    required this.otp,
  });
}

class TimeOutEvent extends AuthenticationEvent {}

class TimerRestartEvent extends AuthenticationEvent {}
