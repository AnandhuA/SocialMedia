import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media/main.dart';
import 'package:social_media/models/chat_model.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/repository/authentication/chat_repo.dart';
import 'package:social_media/repository/authentication/user_repo.dart';

part 'chat_featching_event.dart';
part 'chat_featching_state.dart';

class ChatFeatchingBloc extends Bloc<ChatFeatchingEvent, ChatFeatchingState> {
  ChatFeatchingBloc() : super(ChatFeatchingInitial()) {
    on<FeatchMessageListEvent>(_featchMessageList);
  }

  FutureOr<void> _featchMessageList(
    FeatchMessageListEvent event,
    Emitter<ChatFeatchingState> emit,
  ) async{


















   
      log("start");
      emit(FeatchMessageListLoadingState());
      final Response? getChatlistResponse =
          await ChatRepo.getAllConversations();
      if (getChatlistResponse != null) {
        final decodedChatListResponce = jsonDecode(getChatlistResponse.body);
        log(decodedChatListResponce.toString());
        final List<Conversation> chatList =
            (decodedChatListResponce['data'] as List)
                .map<Conversation>((json) => Conversation.fromJson(json))
                .toList();
        final List<String> userIdList =
            chatList.expand((conversation) => conversation.members).toList();
        final List<UserModel> userList = [];

        for (String id in userIdList) {
          if (id != userId) {
            final Response? getUserResponse =
                await UserRepo.getSingleUser(userid: id);
            if (getUserResponse != null && getUserResponse.statusCode == 200) {
              final decodedGetUserResponce = jsonDecode(getUserResponse.body);

              UserModel user = UserModel.fromJson(decodedGetUserResponce);

              userList.add(user);
            }
          }
        }

        emit(FetchMessageListSuccessState(
            chatList: chatList, userList: userList));
      }
    }
  }

