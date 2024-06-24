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
    if (response != null && response.statusCode == 200) {
      final Map<String, dynamic> decodedResponce = jsonDecode(response.body);

      final List<dynamic> suggestionModelJson = decodedResponce['data'];
      final List<UserModel> suggestionModelList =
          suggestionModelJson.map((json) => UserModel.fromJson(json)).toList();
      emit(SuggestionSuccessState(suggestionModelList: suggestionModelList));
    } else {
      return emit(SuggestionErrorState(error: "error"));
    }
  }
}
