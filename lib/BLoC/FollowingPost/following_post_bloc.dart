import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/repository/authentication/post_repo.dart';

part 'following_post_event.dart';
part 'following_post_state.dart';

class FollowingPostBloc extends Bloc<FollowingPostEvent, FollowingPostState> {
  FollowingPostBloc() : super(FollowingPostInitial()) {
    on<FeatchAllFollowingPostEvent>(_featchAllFollowingPostEvent);
  }

  FutureOr<void> _featchAllFollowingPostEvent(
    FeatchAllFollowingPostEvent event,
    Emitter<FollowingPostState> emit,
  ) async {
    emit(FeatchFollowingPostLoadingState());
    final responce = await PostRepo.getFollowersPost(page: 1);
    if (responce != null) {
      final responseBody = jsonDecode(responce.body);
      final List<PostModel> posts = await responseBody
          .map<PostModel>(
            (json) => PostModel.fromJson(json),
          )
          .toList();

      emit(FeatchFollowingPostSuccessState(posts: posts));
    }
  }
}
