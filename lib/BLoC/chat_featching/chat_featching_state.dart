part of 'chat_featching_bloc.dart';

@immutable
sealed class ChatFeatchingState {}

final class ChatFeatchingInitial extends ChatFeatchingState {}


final class FeatchMessageListLoadingState extends ChatFeatchingState {}

final class FetchMessageListSuccessState extends ChatFeatchingState {
  final List<Conversation> chatList;
  final List<UserModel> userList;

  FetchMessageListSuccessState({
    required this.chatList,
    required this.userList,
  });
}

final class FetchMessageListErrorState extends ChatFeatchingState {
  final String errorMessage;

  FetchMessageListErrorState({required this.errorMessage});
}
