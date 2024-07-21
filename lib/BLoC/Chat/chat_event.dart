part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

// class FeatchMessageListEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String message;
  final String receiverId;
  final String conversationId;

  SendMessageEvent({
    required this.message,
    required this.receiverId,
    required this.conversationId,
  });
}

class ClickUserEvent extends ChatEvent {
  final String conversationId;

  ClickUserEvent({required this.conversationId});
}


class ConnectWebSocketEvent extends ChatEvent {}


class ReceiveMessageEvent extends ChatEvent {
  final Message message;

  ReceiveMessageEvent({required this.message});
}
