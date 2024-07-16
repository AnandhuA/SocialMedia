import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media/repository/authentication/chat_repo.dart';

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
    }
  }
}
