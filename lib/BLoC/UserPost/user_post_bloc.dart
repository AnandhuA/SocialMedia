import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:social_media/repository/authentication/post_repo.dart';

part 'user_post_event.dart';
part 'user_post_state.dart';

class UserPostBloc extends Bloc<UserPostEvent, UserPostState> {
  UserPostBloc() : super(UserPostInitial()) {
    on<ImageSeletedEvent>(_imageSelectedEvent);
    on<PostButtonClickEvent>(_postButtonClick);
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
}
