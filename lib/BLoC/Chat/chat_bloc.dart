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

part 'chat_event.dart';
part 'chat_state.dart';

List<String> list = [];

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendMessageEvent>(_sendMessage);
    on<FeatchMessageListEvent>(_featchMessageList);
  }

  FutureOr<void> _sendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    list.add(event.message);
    emit(ChatSuccessState(chatList: list));
  }

  FutureOr<void> _featchMessageList(
    FeatchMessageListEvent event,
    Emitter<ChatState> emit,
  ) async {
    log("start");
    emit(FeatchMessageListLoadingState());
    final Response? getChatlistResponse = await ChatRepo.getAllConversations();
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
        final Response? getUserResponse =
            await UserRepo.getSingleUser(userid: id);
        if (getUserResponse != null && getUserResponse.statusCode == 200) {
          final decodedGetUserResponce = jsonDecode(getUserResponse.body);

          UserModel user = UserModel.fromJson(decodedGetUserResponce);

          userList.add(user);
        }
      }

      emit(
          FetchMessageListSuccessState(chatList: chatList, userList: userList));
    }
  }
}
