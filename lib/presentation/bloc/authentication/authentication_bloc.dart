import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/repository/authentication/login_repo.dart';
import 'package:social_media/repository/authentication/signup_repo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginButtonClickEvent>(_loginButtonClickEvent);

    on<SignupButtonClickEvent>(_signupButtonClickEvent);

    on<VerificationButtonClickEvent>(_verificationButtonClickEvent);

    on<TimeOutEvent>(_timeOutEvent);

    on<TimerRestartEvent>(_timerRestartEvent);
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
      emit(LoginErrorState(error: "Server Error"));
    }
  }

  FutureOr<void> _signupButtonClickEvent(
    SignupButtonClickEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(SignupLoadingState());
    Response? res = await SignupRepo.userSignUp(userModel: event.userModel);

    if (res != null && res.statusCode == 200) {
      emit(SignupSuccessState(model: event.userModel));
    } else if (res != null) {
      final responseBody = jsonDecode(res.body);
      emit(SignupErrorState(error: responseBody["message"]));
    } else {
      emit(SignupErrorState(error: "Server Error"));
    }
  }

  FutureOr<void> _verificationButtonClickEvent(
    VerificationButtonClickEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(VerificationLoadingState());
    Response? res = await SignupRepo.otpVerification(
      email: event.email,
      otp: event.otp,
    );
    if (res != null && res.statusCode == 200) {
      emit(VerificationSuccessState());
    } else if (res != null) {
      final responseBody = jsonDecode(res.body);
      emit(VerificationErrorState(error: responseBody["message"]));
    } else {
      emit(VerificationErrorState(error: "Server Error"));
    }
  }

  FutureOr<void> _timeOutEvent(
    TimeOutEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(TimeOutState());
  }

  FutureOr<void> _timerRestartEvent(
    TimerRestartEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(TimerRestartState());
  }
}
