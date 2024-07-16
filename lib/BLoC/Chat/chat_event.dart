part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class FeatchMessageListEvent extends ChatEvent{}

class SendMessageEvent extends ChatEvent {
  final String message;

  SendMessageEvent({required this.message});
}

