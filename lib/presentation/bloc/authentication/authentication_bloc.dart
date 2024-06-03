import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media/repository/authentication/login_repo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginButtonClickEvent>(_loginButtonClickEvent);
    on<SignupButtonClickEvent>(_signupButtonClickEvent);
  }

  FutureOr<void> _loginButtonClickEvent(
    LoginButtonClickEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    log("bloc start");
    emit(LoginLoadingState());
    Response? res = await LoginRepo.userLogin(
      email: event.email,
      password: event.password,
    );

    if (res != null && res.statusCode == 200) {
      emit(LoginSuccessState());
    } else if (res != null) {
      final responseBody = jsonDecode(res.body);
      emit(LoginErrorState(error: responseBody["message"]));
    } else {
      emit(LoginErrorState(error: "Error"));
    }
  }

  FutureOr<void> _signupButtonClickEvent(
    SignupButtonClickEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(SignupLoadingState());
  }
}
