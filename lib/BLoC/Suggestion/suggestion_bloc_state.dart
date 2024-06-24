part of 'suggestion_bloc_bloc.dart';

@immutable
sealed class SuggestionBlocState {}

final class SuggestionBlocInitial extends SuggestionBlocState {}

final class SuggestionLoadingState extends SuggestionBlocState {}

final class SuggestionSuccessState extends SuggestionBlocState {
  final List<UserModel> suggestionModelList;

  SuggestionSuccessState({required this.suggestionModelList});
}

final class SuggestionErrorState extends SuggestionBlocState {
  final String error;

  SuggestionErrorState({required this.error});
}
