import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:social_media/repository/authentication/post_repo.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostInitial()) {
    on<ImageSeletedEvent>(_imageSelectedEvent);
    on<PostButtonClickEvent>(_postButtonClick);
  }

  FutureOr<void> _imageSelectedEvent(
    AddPostEvent event,
    Emitter<AddPostState> emit,
  ) {
    emit(ImageSelectedState());
  }

  FutureOr<void> _postButtonClick(
    PostButtonClickEvent event,
    Emitter<AddPostState> emit,
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
