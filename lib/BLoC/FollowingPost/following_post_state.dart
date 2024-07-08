part of 'following_post_bloc.dart';

@immutable
sealed class FollowingPostState {}

final class FollowingPostInitial extends FollowingPostState {}

//---------------fetch post state---------------

final class FeatchFollowingPostLoadingState extends FollowingPostState {}

final class FeatchFollowingPostSuccessState extends FollowingPostState {
  final List<PostModel> posts;

  FeatchFollowingPostSuccessState({required this.posts});
}

final class FeatchFollowingPostErrorState extends FollowingPostState {
  final String error;

  FeatchFollowingPostErrorState({required this.error});
}

//---------------save post state---------------

final class SavePostLoadingState extends FollowingPostState {}

final class UnSavePostLoadingState extends FollowingPostState {}

final class SavePostSuccessState extends FollowingPostState {
  final String postId;

  SavePostSuccessState({required this.postId});
}

final class SavePostErrorState extends FollowingPostState {
  final String error;

  SavePostErrorState({required this.error});
}

//---------------like post state---------------

final class LikeLoadingState extends FollowingPostState {}

final class LikeSuccessState extends FollowingPostState {}

final class LikeErrorState extends FollowingPostState {}

//---------------featch comments state---------------

final class FeatchCommentsLoadingState extends FollowingPostState {}

final class FeatchCommentsSuccessState extends FollowingPostState {
  final List<CommentModel> comments;

  FeatchCommentsSuccessState({required this.comments});
}

final class FeatchCommentsErrorState extends FollowingPostState {}

//-----------------add new comment state---------------

final class AddNewCommentLoadingState extends FollowingPostState {}

final class AddNewCommentSuccesState extends FollowingPostState {}

final class AddNewCommentErrorState extends FollowingPostState {
  final String error;

  AddNewCommentErrorState({required this.error});
}
//-----------------delete comment state---------------
final class DeleteCommentLoadingState extends FollowingPostState {}
final class DeleteCommentSuccessState extends FollowingPostState {}
final class DeleteCommentErrorState extends FollowingPostState {
  final String error;

  DeleteCommentErrorState({required this.error});
}