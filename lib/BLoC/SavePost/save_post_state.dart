part of 'save_post_bloc.dart';

@immutable
sealed class SavePostState {}

final class SavePostInitial extends SavePostState {}

final class SavePostLoadingState extends SavePostState {}

final class SavePostSuccessState extends SavePostState {}

final class SavePostErrorState extends SavePostState {
  final String error;

  SavePostErrorState({required this.error});
}
