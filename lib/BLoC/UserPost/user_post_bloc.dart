import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/repository/authentication/post_repo.dart';

part 'user_post_event.dart';
part 'user_post_state.dart';

class UserPostBloc extends Bloc<UserPostEvent, UserPostState> {
  UserPostBloc() : super(UserPostInitial()) {
    on<ImageSeletedEvent>(_imageSelectedEvent);
    on<PostButtonClickEvent>(_postButtonClick);
    on<FeatchAllMyPostEvent>(_featchMyAllPost);
  }

  FutureOr<void> _imageSelectedEvent(
    UserPostEvent event,
    Emitter<UserPostState> emit,
  ) {
    emit(ImageSelectedState());
  }

  FutureOr<void> _postButtonClick(
    PostButtonClickEvent event,
    Emitter<UserPostState> emit,
  ) async {
    emit(PostLoadingState());
    final response = await PostRepo.addPost(
      event.description,
      event.imagePath,
    );
    if (response != null && response.statusCode == 200) {
      emit(PostSuccessState());
    } else if (response != null) {
      emit(PostErrorState(error: 'something went wrong'));
    } else {
      emit(PostErrorState(error: 'Server error'));
    }
  }

  FutureOr<void> _featchMyAllPost(
    FeatchAllMyPostEvent event,
    Emitter<UserPostState> emit,
  ) async {
    log("===========Start=============");
    emit(FeatchAllMyPostLoadingState());
    log("=============Lading============");
    final response = await PostRepo.fetchPosts();
    if (response != null && response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      log("==========$responseBody===============");

      final List<PostModel> posts = responseBody
          .map<PostModel>((json) => PostModel.fromJson(json))
          .toList();
      log("=========================");
      print(posts);

      return emit(FeatchAllMyPostSuccessState());
    } else if (response != null) {
      final responseBody = jsonDecode(response.body);

      return emit(FeatchAllMyPostErrorState(error: responseBody["message"]));
    } else {
      return emit(FeatchAllMyPostErrorState(error: "something went wrong"));
    }
  }
}
