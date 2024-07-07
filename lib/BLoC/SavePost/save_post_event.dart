part of 'save_post_bloc.dart';

@immutable
sealed class SavePostEvent {}

final class SaveButtonClickEvent extends SavePostEvent {
  final PostModel post;

  SaveButtonClickEvent({required this.post});
}

final class UnSaveButtonClickEvent extends SavePostEvent {
  final PostModel post;

  UnSaveButtonClickEvent({required this.post});
}
