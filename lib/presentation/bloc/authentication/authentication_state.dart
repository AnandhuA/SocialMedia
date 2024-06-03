part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

//-------loginState-------------
final class LoginLoadingState extends AuthenticationState {}

final class LoginErrorState extends AuthenticationState {
  final String error;

  LoginErrorState({required this.error});
}

final class LoginSuccessState extends AuthenticationState {}

//-----------signupState------------

final class SignupLoadingState extends AuthenticationState {}

final class SignupSuccessState extends AuthenticationState {}

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
