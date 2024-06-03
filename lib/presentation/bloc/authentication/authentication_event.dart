part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class LoginButtonClickEvent extends AuthenticationEvent{}

class SignupButtonClickEvent extends AuthenticationEvent{}