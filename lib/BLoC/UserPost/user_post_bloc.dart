import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/repository/authentication/post_repo.dart';
import 'package:social_media/repository/authentication/user_repo.dart';

part 'user_post_event.dart';
part 'user_post_state.dart';

class UserPostBloc extends Bloc<UserPostEvent, UserPostState> {
  UserPostBloc() : super(UserPostInitial()) {
    on<ImageSeletedEvent>(_imageSelectedEvent);
    on<PostButtonClickEvent>(_postButtonClick);
    on<FeatchAllMyPostEvent>(_featchMyAllPost);
    on<DeletePostEvent>(_deletePostEvent);
    on<EditPostButtonClickEvent>(_editPostButtonClick);
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
    emit(AddPostLoadingState());
    final response = await PostRepo.addPost(
      event.description,
      event.imagePath,
    );
    if (response != null && response.statusCode == 200) {
      emit(AddPostSuccessState());
    } else if (response != null) {
      emit(
        AddPostErrorState(error: 'something went wrong'),
      );
    } else {
      emit(AddPostErrorState(error: 'Server error'));
    }
  }

  FutureOr<void> _featchMyAllPost(
    FeatchAllMyPostEvent event,
    Emitter<UserPostState> emit,
  ) async {
    emit(FeatchAllMyPostLoadingState());

    final response = await PostRepo.fetchPosts();
    final res = await UserRepo.fetchCount();
    if (response != null &&
        response.statusCode == 200 &&
        res != null &&
        res.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      final List<PostModel> posts = await responseBody
          .map<PostModel>(
            (json) => PostModel.fromJson(json),
          )
          .toList();

      final Map<String, dynamic> resBody = jsonDecode(res.body);

      return emit(
        FeatchAllMyPostSuccessState(
          postList: posts,
          followersCount: resBody["followersCount"].toString(),
          followingCount: resBody["followingCount"].toString(),
        ),
      );
    } else if (response != null) {
      final responseBody = jsonDecode(response.body);

      return emit(
        FeatchAllMyPostErrorState(
          error: responseBody["message"],
        ),
      );
    } else {
      return emit(
        FeatchAllMyPostErrorState(error: "something went wrong"),
      );
    }
  }

  FutureOr<void> _deletePostEvent(
    DeletePostEvent event,
    Emitter<UserPostState> emit,
  ) async {
    emit(DeletePostLoadingState());
    final response = await PostRepo.deletePost(postId: event.postId);

    if (response != null && response.statusCode == 200) {
      add(FeatchAllMyPostEvent());
      return emit(
        DeletePostSuccessState(),
      );
    } else if (response != null) {
      final responseBody = jsonDecode(response.body);
      return emit(
        DeletePostErrorState(
          error: responseBody['message'],
        ),
      );
    } else {
      return emit(
        DeletePostErrorState(
          error: 'Something went wrong',
        ),
      );
    }
  }

  FutureOr<void> _editPostButtonClick(
    EditPostButtonClickEvent event,
    Emitter<UserPostState> emit,
  ) async {
    emit(AddPostLoadingState());
    final response = await PostRepo.editPost(
      description: event.description,
      imgFile: event.imageFile,
      postId: event.postId,
      imageUrl: event.imageLink,
    );
    if (response != null && response.statusCode == 200) {
      add(FeatchAllMyPostEvent());
      return emit(EditPostSuccessState());
    } else if (response != null && response.statusCode == 500) {
      return emit(
        AddPostErrorState(error: 'Server not responding'),
      );
    } else if (response != null) {
      final responseBody = jsonDecode(response.body);
      return emit(
        AddPostErrorState(
          error: responseBody['message'],
        ),
      );
    } else {
      return emit(
        AddPostErrorState(error: 'Something went wrong'),
      );
    }
  }
}
