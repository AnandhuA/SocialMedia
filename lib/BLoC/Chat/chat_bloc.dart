import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'chat_event.dart';
part 'chat_state.dart';

List<String> list = [];

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendMessageEvent>(_sendMessage);
  }

  FutureOr<void> _sendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    list.add(event.message);
    emit(ChatSuccessState(chatList: list));
  }
}
