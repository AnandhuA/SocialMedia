import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/repository/authentication/post_repo.dart';

part 'save_post_event.dart';
part 'save_post_state.dart';

class SavePostBloc extends Bloc<SavePostEvent, SavePostState> {
  SavePostBloc() : super(SavePostInitial()) {
    on<SaveButtonClickEvent>(_saveButtonClickEvent);
    on<UnSaveButtonClickEvent>(_unSaveButtonClickEvent);
  }

  FutureOr<void> _saveButtonClickEvent(
    SaveButtonClickEvent event,
    Emitter<SavePostState> emit,
  ) async {
    log("save");
    emit(SavePostSuccessState());

    Response? responce = await PostRepo.savePost(postId: event.post.id);
    if (responce != null) {
      final responseBody = jsonDecode(responce.body);
      switch (responce.statusCode) {
        case 200:
          emit(SavePostSuccessState());
          break;
        case 400:
          emit(SavePostErrorState(
              error: "Bad request - ${responseBody["message"]}"));
          break;
        case 401:
          emit(SavePostErrorState(
              error: "Unauthorized - ${responseBody["message"]}"));
          break;
        case 403:
          emit(SavePostErrorState(
              error: "Forbidden - ${responseBody["message"]}"));
          break;
        case 404:
          emit(SavePostErrorState(
              error: "Not found - ${responseBody["message"]}"));
          break;
        case 500:
          emit(SavePostErrorState(
              error: "Internal server error - ${responseBody["message"]}"));
          break;
        default:
          emit(SavePostErrorState(
              error: "HTTP Error - ${responseBody["message"]}"));
          break;
      }
    } else {
      emit(SavePostErrorState(error: "No response received from server"));
    }
  }

  FutureOr<void> _unSaveButtonClickEvent(
    UnSaveButtonClickEvent event,
    Emitter<SavePostState> emit,
  ) async {
    log("unsave");
    emit(SavePostLoadingState());
    Response? responce = await PostRepo.removeSavedPost(postId: event.post.id);
    if (responce != null) {
      final responseBody = jsonDecode(responce.body);
      switch (responce.statusCode) {
        case 200:
          emit(SavePostSuccessState());
          break;
        case 400:
          emit(SavePostErrorState(
              error: "Bad request - ${responseBody["message"]}"));
          break;
        case 401:
          emit(SavePostErrorState(
              error: "Unauthorized - ${responseBody["message"]}"));
          break;
        case 403:
          emit(SavePostErrorState(
              error: "Forbidden - ${responseBody["message"]}"));
          break;
        case 404:
          emit(SavePostErrorState(
              error: "Not found - ${responseBody["message"]}"));
          break;
        case 500:
          emit(SavePostErrorState(
              error: "Internal server error - ${responseBody["message"]}"));
          break;
        default:
          emit(SavePostErrorState(
              error: "HTTP Error - ${responseBody["message"]}"));
          break;
      }
    } else {
      emit(SavePostErrorState(error: "No response received from server"));
    }
  }
}
