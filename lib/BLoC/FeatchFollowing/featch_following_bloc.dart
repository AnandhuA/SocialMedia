import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_media/models/user_model.dart';
import 'package:social_media/repository/authentication/followe_repo.dart';

part 'featch_following_event.dart';
part 'featch_following_state.dart';

class FeatchFollowingBloc
    extends Bloc<FeatchFollowingEvent, FeatchFollowingState> {
  FeatchFollowingBloc() : super(FeatchFollowingInitial()) {
    on<FeatchFollwingListEvent>((event, emit) async {
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
    });

    on<FeatchFollowerListEvent>((event, emit) async {
    
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
    });
  }
}
