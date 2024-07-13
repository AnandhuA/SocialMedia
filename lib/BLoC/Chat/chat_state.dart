part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoadingState extends ChatState {}

final class ChatSuccessState extends ChatState {
  final List<String> chatList;

  ChatSuccessState({required this.chatList});
}

final class ChatErrorState extends ChatState {}
