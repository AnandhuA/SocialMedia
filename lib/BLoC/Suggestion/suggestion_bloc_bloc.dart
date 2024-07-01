import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/repository/authentication/user_repo.dart';

part 'suggestion_bloc_event.dart';
part 'suggestion_bloc_state.dart';

class SuggestionBloc extends Bloc<SuggestionBlocEvent, SuggestionBlocState> {
  SuggestionBloc() : super(SuggestionBlocInitial()) {
    on<SuggestionListFeatchingEvent>(_suggestionListFeatchingEvent);
  }

  FutureOr<void> _suggestionListFeatchingEvent(
    SuggestionListFeatchingEvent event,
    Emitter<SuggestionBlocState> emit,
  ) async {
    emit(SuggestionLoadingState());
    final Response? response = await UserRepo.fetchSuggessionUser();

      if (response != null) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
       

          final List<dynamic> suggestionModelJson = responseBody['data'];
          final List<UserModel> suggestionModelList = suggestionModelJson
              .map((json) => UserModel.fromJson(json))
              .toList();
          emit(
              SuggestionSuccessState(suggestionModelList: suggestionModelList));
          break;
        case 400:
          emit(SuggestionErrorState(
              error: "Bad request - ${responseBody["message"]}"));
          break;
        case 401:
          emit(SuggestionErrorState(
              error: "Unauthorized - ${responseBody["message"]}"));
          break;
        case 403:
          emit(
              SuggestionErrorState(error: "Forbidden - ${responseBody["message"]}"));
          break;
        case 404:
          emit(
              SuggestionErrorState(error: "Not found - ${responseBody["message"]}"));
          break;
        case 500:
          emit(SuggestionErrorState(
              error: "Internal server error - ${responseBody["message"]}"));
          break;
        default:
          emit(SuggestionErrorState(
              error: "HTTP Error - ${responseBody["message"]}"));
          break;
      }
    } else {
      emit(SuggestionErrorState(error: "No response received from server"));
    }
  }
}
