import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media/main.dart';
import 'package:social_media/models/chat_model.dart';
import 'package:social_media/repository/authentication/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

List<Message> list = [];

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendMessageEvent>(_sendMessage);

    on<ClickUserEvent>(_clickUserEvent);
  }

  FutureOr<void> _sendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    await ChatRepo.addMessage(
      recieverId: event.receiverId,
      text: event.message,
      conversationId: event.conversationId,
      senderId: userId,
    );

    add(ClickUserEvent(conversationId: event.conversationId));
    // add(FeatchMessageListEvent());
  }

  FutureOr<void> _clickUserEvent(
    ClickUserEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    final Response? getUserChatResponce =
        await ChatRepo.getAllMessages(conversationId: event.conversationId);

    if (getUserChatResponce != null && getUserChatResponce.statusCode == 200) {
      final getChatlistResponseDecoded = jsonDecode(getUserChatResponce.body);
      final List<Message> chatList =
          (getChatlistResponseDecoded['data'] as List)
              .map((json) => Message.fromJson(json))
              .toList();

      emit(FeatchMessagesSuccessState(messageList: chatList, userId: userId));
    } else {
      return emit(FeatchMessagesErrorState(errorMessage: "ennjdjasf"));
    }
  }
}
