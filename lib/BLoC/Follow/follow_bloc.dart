import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_media/models/user_model.dart';
import 'package:social_media/repository/authentication/followe_repo.dart';

part 'follow_event.dart';
part 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  FollowBloc() : super(FeatchFollowingInitial()) {
    on<FeatchFollwingListEvent>(_featchFollwingListEvent);
    on<FeatchFollowerListEvent>(_featchFollowerListEvent);
    on<FollowButtonClickEvent>(_followButtonClickEvent);
    on<UnFollowButtonClickEvent>(_unFollowButtonClickEvent);
  }

  FutureOr<void> _featchFollwingListEvent(
    FeatchFollwingListEvent event,
    Emitter<FollowState> emit,
  ) async {
    emit(FeatchFollowingLoadingState());

    final http.Response? responce = await FolloweRepo.fetchFollowing();

    if (responce != null) {
      final responseBody = jsonDecode(responce.body);
      switch (responce.statusCode) {
        case 200:
          final Map<String, dynamic> decodedResponce =
              jsonDecode(responce.body);
          final List<dynamic> followersJson = decodedResponce['following'];
          final List<UserModel> following =
              followersJson.map((json) => UserModel.fromJson(json)).toList();
          emit(
            FeatchFollowingSuccessState(follwingList: following),
          );
          break;
        case 400:
          emit(FeatchFollowingErrorState(
              error: "Bad request - ${responseBody["message"]}"));
          break;
        case 401:
          emit(FeatchFollowingErrorState(
              error: "Unauthorized - ${responseBody["message"]}"));
          break;
        case 403:
          emit(FeatchFollowingErrorState(
              error: "Forbidden - ${responseBody["message"]}"));
          break;
        case 404:
          emit(FeatchFollowingErrorState(
              error: "Not found - ${responseBody["message"]}"));
          break;
        case 500:
          emit(FeatchFollowingErrorState(
              error: "Internal server error - ${responseBody["message"]}"));
          break;
        default:
          emit(FeatchFollowingErrorState(
              error: "HTTP Error - ${responseBody["message"]}"));
          break;
      }
    } else {
      emit(
          FeatchFollowingErrorState(error: "No response received from server"));
    }
  }

  FutureOr<void> _featchFollowerListEvent(
    FeatchFollowerListEvent event,
    Emitter<FollowState> emit,
  ) async {
    emit(FeatchFollowingLoadingState());

    final http.Response? responce = await FolloweRepo.fetchFollowers();


    if (responce != null) {
      final responseBody = jsonDecode(responce.body);
      switch (responce.statusCode) {
        case 200:
          final Map<String, dynamic> decodedResponce =
              jsonDecode(responce.body);

          final List<dynamic> followersJson = decodedResponce['followers'];
          final List<UserModel> followers =
              followersJson.map((json) => UserModel.fromJson(json)).toList();
          emit(FeatchFollowerSuccessState(followerList: followers));
          break;
        case 400:
          emit(FeatchFollowingErrorState(
              error: "Bad request - ${responseBody["message"]}"));
          break;
        case 401:
          emit(FeatchFollowingErrorState(
              error: "Unauthorized - ${responseBody["message"]}"));
          break;
        case 403:
          emit(FeatchFollowingErrorState(
              error: "Forbidden - ${responseBody["message"]}"));
          break;
        case 404:
          emit(FeatchFollowingErrorState(
              error: "Not found - ${responseBody["message"]}"));
          break;
        case 500:
          emit(FeatchFollowingErrorState(
              error: "Internal server error - ${responseBody["message"]}"));
          break;
        default:
          emit(FeatchFollowingErrorState(
              error: "HTTP Error - ${responseBody["message"]}"));
          break;
      }
    } else {
      emit(
          FeatchFollowingErrorState(error: "No response received from server"));
    }
  }

  FutureOr<void> _followButtonClickEvent(
    FollowButtonClickEvent event,
    Emitter<FollowState> emit,
  ) async {
    emit(FollowUserLoadingState());
    final http.Response? responce =
        await FolloweRepo.followUser(followId: event.user.id);
  

     if (responce != null) {
      final responseBody = jsonDecode(responce.body);
      switch (responce.statusCode) {
        case 200:
       Map<String, dynamic> responseBody = jsonDecode(responce.body);

          List connectionUserId = responseBody['userConnection']["following"];
          emit(FollowUserSuccessState(connectionUserId: connectionUserId));
          break;
        case 400:
          emit(FollowUserErrorState(
              error: "Bad request - ${responseBody["message"]}"));
          break;
        case 401:
          emit(FollowUserErrorState(
              error: "Unauthorized - ${responseBody["message"]}"));
          break;
        case 403:
          emit(FollowUserErrorState(
              error: "Forbidden - ${responseBody["message"]}"));
          break;
        case 404:
          emit(FollowUserErrorState(
              error: "Not found - ${responseBody["message"]}"));
          break;
        case 500:
          emit(FollowUserErrorState(
              error: "Internal server error - ${responseBody["message"]}"));
          break;
        default:
          emit(FollowUserErrorState(
              error: "HTTP Error - ${responseBody["message"]}"));
          break;
      }
    } else {
      emit(
          FeatchFollowingErrorState(error: "No response received from server"));
    }
  }

  FutureOr<void> _unFollowButtonClickEvent(
    UnFollowButtonClickEvent event,
    Emitter<FollowState> emit,
  ) async {
    final http.Response? response =
        await FolloweRepo.unfollowUser(followId: event.user.id);
  
     if (response != null) {
      final responseBody = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          break;
        case 400:
          emit(UnFollowUserErrorState(
              error: "Bad request - ${responseBody["message"]}"));
          break;
        case 401:
          emit(UnFollowUserErrorState(
              error: "Unauthorized - ${responseBody["message"]}"));
          break;
        case 403:
          emit(UnFollowUserErrorState(
              error: "Forbidden - ${responseBody["message"]}"));
          break;
        case 404:
          emit(UnFollowUserErrorState(
              error: "Not found - ${responseBody["message"]}"));
          break;
        case 500:
          emit(UnFollowUserErrorState(
              error: "Internal server error - ${responseBody["message"]}"));
          break;
        default:
          emit(UnFollowUserErrorState(
              error: "HTTP Error - ${responseBody["message"]}"));
          break;
      }
    } else {
      emit(
          UnFollowUserErrorState(error: "No response received from server"));
    }
  }
}
