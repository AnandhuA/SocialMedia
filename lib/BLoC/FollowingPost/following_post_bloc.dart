import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/repository/authentication/post_repo.dart';

part 'following_post_event.dart';
part 'following_post_state.dart';

class FollowingPostBloc extends Bloc<FollowingPostEvent, FollowingPostState> {
  FollowingPostBloc() : super(FollowingPostInitial()) {
    on<FeatchAllFollowingPostEvent>(_featchAllFollowingPostEvent);
    on<SaveButtonClickEvent>(_saveButtonClickEvent);
    on<UnSaveButtonClickEvent>(_unSaveButtonClickEvent);
  }

  FutureOr<void> _featchAllFollowingPostEvent(
    FeatchAllFollowingPostEvent event,
    Emitter<FollowingPostState> emit,
  ) async {
    emit(FeatchFollowingPostLoadingState());
    final responce = await PostRepo.getFollowersPost(page: 1);
    if (responce != null) {
      final responseBody = jsonDecode(responce.body);
      // log(responseBody.toString());
      final List<PostModel> posts = await responseBody
          .map<PostModel>(
            (json) => PostModel.fromJson(json),
          )
          .toList();
      emit(FeatchFollowingPostSuccessState(posts: posts));
    }
  }

  FutureOr<void> _saveButtonClickEvent(
    SaveButtonClickEvent event,
    Emitter<FollowingPostState> emit,
  ) async {
    log("save");
    emit(SavePostLoadingState());

    Response? saveResponce = await PostRepo.savePost(postId: event.post.id);
    final postListResponce = await PostRepo.getFollowersPost(page: 1);
    if (saveResponce != null && saveResponce.body.isNotEmpty) {
      final saveResponceBody = jsonDecode(saveResponce.body);
      switch (saveResponce.statusCode) {
        case 200:
          log(saveResponce.body);

          if (postListResponce != null && postListResponce.body.isNotEmpty) {
            final postListresponcBody = jsonDecode(postListResponce.body);
            // log(responseBody.toString());
            final List<PostModel> posts = await postListresponcBody
                .map<PostModel>(
                  (json) => PostModel.fromJson(json),
                )
                .toList();
            log("set mone un");
            emit(FeatchFollowingPostSuccessState(posts: posts));
            // emit(SavePostSuccessState(postId: saveResponceBody["postId"]));
          } else {
            emit(SavePostErrorState(error: "No response received from server"));
          }
          break;
        case 400:
          emit(SavePostErrorState(
              error: "Bad request - ${saveResponceBody["message"]}"));
          break;
        case 401:
          emit(SavePostErrorState(
              error: "Unauthorized - ${saveResponceBody["message"]}"));
          break;
        case 403:
          emit(SavePostErrorState(
              error: "Forbidden - ${saveResponceBody["message"]}"));
          break;
        case 404:
          emit(SavePostErrorState(
              error: "Not found - ${saveResponceBody["message"]}"));
          break;
        case 500:
          emit(SavePostErrorState(
              error: "Internal server error - ${saveResponceBody["message"]}"));
          break;
        default:
          emit(SavePostErrorState(
              error: "HTTP Error - ${saveResponceBody["message"]}"));
          break;
      }
    } else {
      emit(SavePostErrorState(error: "No response received from server"));
    }
  }

  FutureOr<void> _unSaveButtonClickEvent(
    UnSaveButtonClickEvent event,
    Emitter<FollowingPostState> emit,
  ) async {
    log("unsave");
    emit(SavePostLoadingState());
    Response? saveResponce =
        await PostRepo.removeSavedPost(postId: event.post.id);
    final postListresponc = await PostRepo.getFollowersPost(page: 1);
    if (saveResponce != null && saveResponce.body.isNotEmpty) {
      final saveResponceBody = jsonDecode(saveResponce.body);
      switch (saveResponce.statusCode) {
        case 200:
          if (postListresponc != null && postListresponc.body.isNotEmpty) {
            final postlistBody = jsonDecode(postListresponc.body);
            // log(responseBody.toString());
            final List<PostModel> posts = await postlistBody
                .map<PostModel>(
                  (json) => PostModel.fromJson(json),
                )
                .toList();
            log("set mone");
            emit(FeatchFollowingPostSuccessState(posts: posts));
            // emit(SavePostSuccessState(postId: saveResponceBody["postId"]));
          } else {
            emit(SavePostErrorState(error: "No response received from server"));
          }
          break;
        case 400:
          emit(SavePostErrorState(
              error: "Bad request - ${saveResponceBody["message"]}"));
          break;
        case 401:
          emit(SavePostErrorState(
              error: "Unauthorized - ${saveResponceBody["message"]}"));
          break;
        case 403:
          emit(SavePostErrorState(
              error: "Forbidden - ${saveResponceBody["message"]}"));
          break;
        case 404:
          emit(SavePostErrorState(
              error: "Not found - ${saveResponceBody["message"]}"));
          break;
        case 500:
          emit(SavePostErrorState(
              error: "Internal server error - ${saveResponceBody["message"]}"));
          break;
        default:
          emit(SavePostErrorState(
              error: "HTTP Error - ${saveResponceBody["message"]}"));
          break;
      }
    } else {
      emit(SavePostErrorState(error: "No response received from server"));
    }
  }
}
