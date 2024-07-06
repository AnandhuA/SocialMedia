import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/repository/authentication/post_repo.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikeBloc() : super(LikeInitial()) {
    on<UserLikeEvent>(_userLikeEvent);
    on<UserUnLikeEvent>(_userUnLikeEvent);
  }

  FutureOr<void> _userLikeEvent(
    UserLikeEvent event,
    Emitter<LikeState> emit,
  ) async {
    final Response? responce = await PostRepo.likePost(postId: event.post.id);
  }

  FutureOr<void> _userUnLikeEvent(
    UserUnLikeEvent event,
    Emitter<LikeState> emit,
  ) async {
    final Response? responce = await PostRepo.unlikePost(postId: event.post.id);
  }
}
