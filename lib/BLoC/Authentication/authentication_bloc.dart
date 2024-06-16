import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media/models/auth_user_model.dart';
import 'package:social_media/repository/authentication/authentication_repo.dart';

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

    on<ForgotPasswordSendOtpButtonClickEvent>(
        _forgotPasswordSendOtpButtonClick);

    on<ForgotPasswordOtpVerficationButtonClickEvent>(
        _forgotPasswordVerificationOtpButtonClick);

    on<NewPasswordSaveButtonClickEvent>(_newPasswordSaveButtonClick);
    on<LoginWithGoogleClickEvent>(_loginWithGoogle);
  }

  FutureOr<void> _loginButtonClickEvent(
    LoginButtonClickEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    log("bloc start");
    emit(LoginLoadingState());
    Response? res = await AuthenticationRepo.userLogin(
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
    Response? res =
        await AuthenticationRepo.userSignUp(userModel: event.userModel);

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
    Response? res = await AuthenticationRepo.otpVerification(
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

  FutureOr<void> _forgotPasswordSendOtpButtonClick(
    ForgotPasswordSendOtpButtonClickEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(ForgotPasswordLoadingState());
    Response? res = await AuthenticationRepo.forgotPassword(email: event.email);

    if (res != null && res.statusCode == 200) {
      final responseBody = jsonDecode(res.body);
      if (responseBody["status"] == 200) {
        emit(ForgotPasswordSuccessState());
      } else {
        emit(ForgotPasswordErrorState(error: responseBody["message"]));
      }
    } else {
      emit(ForgotPasswordErrorState(error: "Server Error"));
    }
  }

  FutureOr<void> _forgotPasswordVerificationOtpButtonClick(
    ForgotPasswordOtpVerficationButtonClickEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(VerificationLoadingState());
    Response? res = await AuthenticationRepo.verifyOtpForgotPassword(
      email: event.email,
      otp: event.otp,
    );
    if (res != null && res.statusCode == 200) {
      final responseBody = jsonDecode(res.body);
      if (responseBody["status"]) {
        return emit(VerificationSuccessState());
      } else {
        return emit(VerificationErrorState(error: 'invalid OTP'));
      }
    } else {
      return emit(VerificationErrorState(error: 'Server error'));
    }
  }

  FutureOr<void> _newPasswordSaveButtonClick(
    NewPasswordSaveButtonClickEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(NewPasswordLoadingState());
    Response? res = await AuthenticationRepo.setNewPassword(
      email: event.email,
      password: event.password,
    );

    if (res != null && res.statusCode == 200) {
      return emit(NewPasswordSuccessState());
    } else if (res != null) {
      final responseBody = jsonDecode(res.body);
      return emit(NewPasswordErrorState(error: responseBody["message"]));
    } else {
      return emit(NewPasswordErrorState(error: 'Server error'));
    }
  }

  FutureOr<void> _loginWithGoogle(
    LoginWithGoogleClickEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(LoginWithGoogleLoadingState());
    UserCredential? response = await AuthenticationRepo.siginWithGoogle();

    if (response != null &&
        response.user != null &&
        response.user!.email != null) {
      String? email = response.user!.email;
   
      Response? finalResponse = await AuthenticationRepo.googleLogin(email!);
      if (finalResponse != null && finalResponse.statusCode == 200) {
        return emit(LoginSuccessState());
      } else if (finalResponse != null) {
        final errorMessage = jsonDecode(finalResponse.body);

        emit(LoginErrorState(error: errorMessage["message"]));
      } else {
        return emit(LoginErrorState(error: 'Server Error'));
      }
    } else {
      emit(LoginErrorState(error: 'account not found'));
    }
  }
}
