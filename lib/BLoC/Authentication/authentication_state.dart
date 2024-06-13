part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

//-------loginState-------------

final class LoginLoadingState extends AuthenticationState {}

final class LoginSuccessState extends AuthenticationState {}

final class LoginErrorState extends AuthenticationState {
  final String error;

  LoginErrorState({required this.error});
}

final class LoginWithGoogleLoadingState extends AuthenticationState {}
//-----------signupState------------

final class SignupLoadingState extends AuthenticationState {}

final class SignupSuccessState extends AuthenticationState {
  final UserModel model;

  SignupSuccessState({required this.model});
}

final class SignupErrorState extends AuthenticationState {
  final String error;

  SignupErrorState({required this.error});
}

//-------------verification---------

final class VerificationLoadingState extends AuthenticationState {}

final class VerificationSuccessState extends AuthenticationState {}

final class VerificationErrorState extends AuthenticationState {
  final String error;

  VerificationErrorState({required this.error});
}

final class TimeOutState extends AuthenticationState {}

final class TimerRestartState extends AuthenticationState {}

//--------------forgot Password-----------------

final class ForgotPasswordLoadingState extends AuthenticationState {}

final class ForgotPasswordSuccessState extends AuthenticationState {}

final class ForgotPasswordErrorState extends AuthenticationState {
  final String error;

  ForgotPasswordErrorState({required this.error});
}

final class NewPasswordLoadingState extends AuthenticationState {}

final class NewPasswordSuccessState extends AuthenticationState {}

final class NewPasswordErrorState extends AuthenticationState {
  final String error;

  NewPasswordErrorState({required this.error});
}

