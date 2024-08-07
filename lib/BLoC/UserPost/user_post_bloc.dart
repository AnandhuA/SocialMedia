import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/models/saved_post_model.dart';
import 'package:social_media/models/user_model.dart';
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
    on<FeatchUserPostEvent>(_featchUserPostEvent);
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

    if (response != null) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          emit(AddPostSuccessState());

          break;
        case 400:
          emit(AddPostErrorState(
              error: "Bad request - ${responseBody["message"]}"));
          break;
        case 401:
          emit(AddPostErrorState(
              error: "Unauthorized - ${responseBody["message"]}"));
          break;
        case 403:
          emit(AddPostErrorState(
              error: "Forbidden - ${responseBody["message"]}"));
          break;
        case 404:
          emit(AddPostErrorState(
              error: "Not found - ${responseBody["message"]}"));
          break;
        case 500:
          emit(AddPostErrorState(
              error: "Internal server error - ${responseBody["message"]}"));
          break;
        default:
          emit(AddPostErrorState(
              error: "HTTP Error - ${responseBody["message"]}"));
          break;
      }
    } else {
      emit(AddPostErrorState(error: "No response received from server"));
    }
  }

  FutureOr<void> _featchMyAllPost(
    FeatchAllMyPostEvent event,
    Emitter<UserPostState> emit,
  ) async {
    emit(FeatchAllMyPostLoadingState());

    final response = await PostRepo.fetchPosts();
    final res = await UserRepo.fetchCount();
    final savedPostRes = await PostRepo.fetchSavedPosts();
    Map<String, dynamic> resBody;
    if (response != null &&
        response.statusCode == 200 &&
        res != null &&
        res.statusCode == 200 &&
        savedPostRes != null &&
        savedPostRes.statusCode == 200 &&
        response.body.isNotEmpty &&
        res.body.isNotEmpty &&
        savedPostRes.body.isNotEmpty) {
      final responseBody = jsonDecode(response.body);
      final savedResBody = jsonDecode(savedPostRes.body);
      if (res.body.isNotEmpty) {
        resBody = jsonDecode(res.body);
      } else {
        resBody = {"followersCount": 0, "followingCount": 0};
      }
      // log(resBody.toString());
      final List<PostModel> posts = await responseBody
          .map<PostModel>(
            (json) => PostModel.fromJson(json),
          )
          .toList();

      final List<SavePostModel> savedPosts = savedResBody
          .map<SavePostModel>((json) => SavePostModel.fromJson(json))
          .toList();

      // print(savedPosts);
      return emit(
        FeatchAllMyPostSuccessState(
          postList: posts,
          savedPostList: savedPosts,
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

    if (response != null) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          add(FeatchAllMyPostEvent());
          emit(
            DeletePostSuccessState(),
          );

          break;
        case 400:
          emit(DeletePostErrorState(
              error: "Bad request - ${responseBody["message"]}"));
          break;
        case 401:
          emit(DeletePostErrorState(
              error: "Unauthorized - ${responseBody["message"]}"));
          break;
        case 403:
          emit(DeletePostErrorState(
              error: "Forbidden - ${responseBody["message"]}"));
          break;
        case 404:
          emit(DeletePostErrorState(
              error: "Not found - ${responseBody["message"]}"));
          break;
        case 500:
          emit(DeletePostErrorState(
              error: "Internal server error - ${responseBody["message"]}"));
          break;
        default:
          emit(DeletePostErrorState(
              error: "HTTP Error - ${responseBody["message"]}"));
          break;
      }
    } else {
      emit(DeletePostErrorState(error: "No response received from server"));
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

    if (response != null) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          add(FeatchAllMyPostEvent());
          emit(EditPostSuccessState());

          break;
        case 400:
          emit(AddPostErrorState(
              error: "Bad request - ${responseBody["message"]}"));
          break;
        case 401:
          emit(AddPostErrorState(
              error: "Unauthorized - ${responseBody["message"]}"));
          break;
        case 403:
          emit(AddPostErrorState(
              error: "Forbidden - ${responseBody["message"]}"));
          break;
        case 404:
          emit(AddPostErrorState(
              error: "Not found - ${responseBody["message"]}"));
          break;
        case 500:
          emit(AddPostErrorState(
              error: "Internal server error - ${responseBody["message"]}"));
          break;
        default:
          emit(AddPostErrorState(
              error: "HTTP Error - ${responseBody["message"]}"));
          break;
      }
    } else {
      emit(AddPostErrorState(error: "No response received from server"));
    }
  }

  FutureOr<void> _featchUserPostEvent(
    FeatchUserPostEvent event,
    Emitter<UserPostState> emit,
  ) async {
    emit(FeatchUserPostLoadingState());
    final responce = await PostRepo.fetchUserOtherPosts(userId: event.user.id);
    // final response = await FolloweRepo.isFollowing(userid: event.user.id);
    if (responce != null &&
        responce.statusCode == 200 &&
        responce.body.isNotEmpty) {
      final responseBody = jsonDecode(responce.body);
      // log(responseBody.toString());
      final List<PostModel> posts = await responseBody
          .map<PostModel>(
            (json) => PostModel.fromJson(json),
          )
          .toList();

      emit(FeatchUserPostSuccessState(postList: posts));
    } else {
      emit(FeatchUserPostErrorState());
    }
  }
}
