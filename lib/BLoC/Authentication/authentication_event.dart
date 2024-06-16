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
  final AuthUserModel userModel;

  SignupButtonClickEvent({required this.userModel});
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

class ForgotPasswordSendOtpButtonClickEvent extends AuthenticationEvent {
  final String email;

  ForgotPasswordSendOtpButtonClickEvent({required this.email});
}

class ForgotPasswordOtpVerficationButtonClickEvent extends AuthenticationEvent {
  final String email;
  final String otp;

  ForgotPasswordOtpVerficationButtonClickEvent({
    required this.email,
    required this.otp,
  });
}

class NewPasswordSaveButtonClickEvent extends AuthenticationEvent {
  final String email;
  final String password;

  NewPasswordSaveButtonClickEvent({
    required this.email,
    required this.password,
  });
}


class  LoginWithGoogleClickEvent extends AuthenticationEvent{}