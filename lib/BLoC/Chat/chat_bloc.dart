import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media/core/urls.dart';
import 'package:social_media/main.dart';
import 'package:social_media/models/chat_model.dart';
import 'package:social_media/repository/authentication/chat_repo.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'chat_event.dart';
part 'chat_state.dart';

List<Message> list = [];

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  WebSocketChannel? _channel;
  ChatBloc() : super(ChatInitial()) {
    on<SendMessageEvent>(_sendMessage);
    on<ConnectWebSocketEvent>(_connectWebSocket);
    on<ReceiveMessageEvent>(_receiveMessage);
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

  void _connectWebSocket(ConnectWebSocketEvent event, Emitter<ChatState> emit) {
    _channel = WebSocketChannel.connect(Uri.parse('wss://z9c1mk58-7002.inc1.devtunnels.ms/'));

    _channel!.stream.listen((data) {
      final message = Message.fromJson(jsonDecode(data));
      add(ReceiveMessageEvent(message: message));
    });
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

  void _receiveMessage(ReceiveMessageEvent event, Emitter<ChatState> emit) {
    if (state is FeatchMessagesSuccessState) {
      log("set mone");
      final currentState = state as FeatchMessagesSuccessState;
      final updatedMessages = List<Message>.from(currentState.messageList)
        ..add(event.message);
      emit(FeatchMessagesSuccessState(
          messageList: updatedMessages, userId: userId));
    }
  }

  @override
  Future<void> close() {
    _channel?.sink.close();
    return super.close();
  }
}
