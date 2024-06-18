import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/repository/authentication/user_repo.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc() : super(UserDetailsInitial()) {
    on<FeatchUserDetailsEvent>(_featchUserDetails);
  }

  FutureOr<void> _featchUserDetails(
    FeatchUserDetailsEvent event,
    Emitter<UserDetailsState> emit,
  ) async {
    emit(FeatchUserDetailsLoadingState());
    final response = await UserRepo.fetchLoggedInUserDetails();
    

    if (response != null &&
        response.statusCode == 200 ) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
    
      UserModel userDetails = UserModel.fromJson(responseBody);
      emit(
        FeatchUserDetailsSuccessState(
          userDetails: userDetails,
         
        ),
      );
    } else {
      return emit(FeatchUserDetailsErrorState(error: "error"));
    }
  }
}
