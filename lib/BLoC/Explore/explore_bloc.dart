import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/repository/authentication/post_repo.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreInitial()) {
    on<FeatchExplorePostEvent>(_featchExplorePostEvent);
  }

  FutureOr<void> _featchExplorePostEvent(
    FeatchExplorePostEvent event,
    Emitter<ExploreState> emit,
  ) async {
    emit(FeatchExplorePostLoadingState());

    final Response? response = await PostRepo.fetchExplorePosts();

    if (response != null) {
      final responseBody = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          final List<PostModel> posts = await responseBody
              .map<PostModel>(
                (json) => PostModel.fromJson(json),
              )
              .toList();
          emit(FeatchExplorePostSuccessState(posts: posts));
          break;
        case 400:
          emit(FeatchExplorePostErrorState(
              error: "Bad request - ${responseBody["message"]}"));
          break;
        case 401:
          emit(FeatchExplorePostErrorState(
              error: "Unauthorized - ${responseBody["message"]}"));
          break;
        case 403:
          emit(FeatchExplorePostErrorState(
              error: "Forbidden - ${responseBody["message"]}"));
          break;
        case 404:
          emit(FeatchExplorePostErrorState(
              error: "Not found - ${responseBody["message"]}"));
          break;
        case 500:
          emit(FeatchExplorePostErrorState(
              error: "Internal server error - ${responseBody["message"]}"));
          break;
        default:
          emit(FeatchExplorePostErrorState(
              error: "HTTP Error - ${responseBody["message"]}"));
          break;
      }
    } else {
      emit(FeatchExplorePostErrorState(
          error: "No response received from server"));
    }
  }
}
