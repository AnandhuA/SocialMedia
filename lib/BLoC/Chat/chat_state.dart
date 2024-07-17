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

final class FeatchMessageListLoadingState extends ChatState {}

final class FetchMessageListSuccessState extends ChatState {
  final List<Conversation> chatList;
  final List<UserModel> userList;

  FetchMessageListSuccessState({
    required this.chatList,
    required this.userList,
  });
}

final class FetchMessageListErrorState extends ChatState {
  final String errorMessage;

  FetchMessageListErrorState({required this.errorMessage});
}
