import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/repository/authentication/user_repo.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc() : super(UserDetailsInitial()) {
    on<FeatchUserDetailsEvent>(_featchUserDetails);
    on<EditUserDetailsEvent>(_editUserDetailsEvent);
  }

  FutureOr<void> _featchUserDetails(
    FeatchUserDetailsEvent event,
    Emitter<UserDetailsState> emit,
  ) async {
    emit(FeatchUserDetailsLoadingState());
    final response = await UserRepo.fetchLoggedInUserDetails();

    if (response != null) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          UserModel userDetails = UserModel.fromJson(responseBody);
          emit(
            FeatchUserDetailsSuccessState(
              userDetails: userDetails,
            ),
          );

          break;
        case 400:
          emit(FeatchUserDetailsErrorState(
              error: "Bad request - ${responseBody["message"]}"));
          break;
        case 401:
          emit(FeatchUserDetailsErrorState(
              error: "Unauthorized - ${responseBody["message"]}"));
          break;
        case 403:
          emit(FeatchUserDetailsErrorState(
              error: "Forbidden - ${responseBody["message"]}"));
          break;
        case 404:
          emit(FeatchUserDetailsErrorState(
              error: "Not found - ${responseBody["message"]}"));
          break;
        case 500:
          emit(FeatchUserDetailsErrorState(
              error: "Internal server error - ${responseBody["message"]}"));
          break;
        default:
          emit(FeatchUserDetailsErrorState(
              error: "HTTP Error - ${responseBody["message"]}"));
          break;
      }
    } else {
      emit(FeatchUserDetailsErrorState(
          error: "No response received from server"));
    }
  }

  FutureOr<void> _editUserDetailsEvent(
    EditUserDetailsEvent event,
    Emitter<UserDetailsState> emit,
  ) async {
    emit(EditUserDetailsLoadingState());
    final response = await UserRepo.editProfile(
      name: event.name,
      bio: event.bio,
      coverPhoto: event.coverPhoto,
      profilePhoto: event.profilePhoto,
    );
    if (response != null) {
      log(response.body);
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          log(response.body);
          emit(EditUserDetailsSuccessState());
          add(FeatchUserDetailsEvent());
          break;
        case 400:
          emit(EditUserDetailsErrorState(
              error: "Bad request - ${responseBody["message"]}"));
          break;
        case 401:
          emit(EditUserDetailsErrorState(
              error: "Unauthorized - ${responseBody["message"]}"));
          break;
        case 403:
          emit(EditUserDetailsErrorState(
              error: "Forbidden - ${responseBody["message"]}"));
          break;
        case 404:
          emit(EditUserDetailsErrorState(
              error: "Not found - ${responseBody["message"]}"));
          break;
        case 500:
          emit(EditUserDetailsErrorState(
              error: "Internal server error - ${responseBody["message"]}"));
          break;
        default:
          emit(EditUserDetailsErrorState(
              error: "HTTP Error - ${responseBody["message"]}"));
          break;
      }
    } else {
      emit(
          EditUserDetailsErrorState(error: "No response received from server"));
    }
  }
}
