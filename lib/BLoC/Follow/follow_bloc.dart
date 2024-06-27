import 'dart:async';
import 'dart:convert';
import 'dart:developer';

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
    if (responce != null && responce.statusCode == 200) {
      final Map<String, dynamic> decodedResponce = jsonDecode(responce.body);
      final List<dynamic> followersJson = decodedResponce['following'];
      final List<UserModel> following =
          followersJson.map((json) => UserModel.fromJson(json)).toList();
      emit(
        FeatchFollowingSuccessState(follwingList: following),
      );
    } else {
      emit(
        FeatchFollowingErrorState(error: "Somethig Wrong"),
      );
    }
  }

  FutureOr<void> _featchFollowerListEvent(
    FeatchFollowerListEvent event,
    Emitter<FollowState> emit,
  ) async {
    emit(FeatchFollowingLoadingState());

    final http.Response? responce = await FolloweRepo.fetchFollowers();

    if (responce != null && responce.statusCode == 200) {
      final Map<String, dynamic> decodedResponce = jsonDecode(responce.body);

      final List<dynamic> followersJson = decodedResponce['followers'];
      final List<UserModel> followers =
          followersJson.map((json) => UserModel.fromJson(json)).toList();
      emit(FeatchFollowerSuccessState(followerList: followers));
    } else {
      emit(
        FeatchFollowingErrorState(error: "Somethig Wrong"),
      );
    }
  }

  FutureOr<void> _followButtonClickEvent(
    FollowButtonClickEvent event,
    Emitter<FollowState> emit,
  ) async {
    emit(FollowUserLoadingState());
    log("follw");
    final http.Response? responce =
        await FolloweRepo.followUser(followId: event.user.id);
    if (responce != null && responce.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(responce.body);

      List connectionUserId = responseBody['userConnection']["following"];
      log("follwset");
      emit(FollowUserSuccessState(connectionUserId: connectionUserId));
    } else {
      emit(FollowUserErrorState());
    }
  }

  FutureOr<void> _unFollowButtonClickEvent(
    UnFollowButtonClickEvent event,
    Emitter<FollowState> emit,
  ) async {
    emit(UnFollowUserLoadingState());
    log("unfollw");
    final http.Response? response =
        await FolloweRepo.unfollowUser(followId: event.user.id);
    if (response != null && response.statusCode == 200) {
      log("unfollwset");
    }
  }
}
