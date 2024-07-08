part of 'following_post_bloc.dart';

@immutable
sealed class FollowingPostEvent {}

//----------featchAllFollowingPostEvent----------
final class FeatchAllFollowingPostEvent extends FollowingPostEvent {}

//----------saveButtonClickEvent----------
final class SaveButtonClickEvent extends FollowingPostEvent {
  final PostModel post;

  SaveButtonClickEvent({required this.post});
}

//----------unSaveButtonClickEvent----------
final class UnSaveButtonClickEvent extends FollowingPostEvent {
  final PostModel post;

  UnSaveButtonClickEvent({required this.post});
}

//----------likeButtonClickEvent----------
final class LikeEvent extends FollowingPostEvent {
  final PostModel post;

  LikeEvent({required this.post});
}

//----------unLikeButtonClickEvent----------
final class UnLikeEvent extends FollowingPostEvent {
  final PostModel post;

  UnLikeEvent({required this.post});
}

//----------commentButtonClickEvent----------

final class CommentButtonClickEvent extends FollowingPostEvent {
  final PostModel post;

  CommentButtonClickEvent({required this.post});
}

//------------AddCommentEvent----------

final class AddNewCommentEvent extends FollowingPostEvent {
  final PostModel post;
  final String comment;

  AddNewCommentEvent({required this.post, required this.comment});
}

//------------DeleteCommentEvent----------

final class DeleteCommentEvent extends FollowingPostEvent {
  final CommentModel comment;
    final PostModel post;

  DeleteCommentEvent({required this.comment,required this.post});
}