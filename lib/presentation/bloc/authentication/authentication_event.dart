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
  final String name;
  final String email;
  final String phone;
  final String password;

  SignupButtonClickEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
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

class TimeOutEvent extends AuthenticationEvent{}
class TimerRestartEvent extends AuthenticationEvent {}
