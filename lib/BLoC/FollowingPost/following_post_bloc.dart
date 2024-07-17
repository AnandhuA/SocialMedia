import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media/models/comment_model.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/repository/authentication/post_repo.dart';

part 'following_post_event.dart';
part 'following_post_state.dart';

class FollowingPostBloc extends Bloc<FollowingPostEvent, FollowingPostState> {
  FollowingPostBloc() : super(FollowingPostInitial()) {
    on<FeatchAllFollowingPostEvent>(_featchAllFollowingPostEvent);
    on<SaveButtonClickEvent>(_saveButtonClickEvent);
    on<UnSaveButtonClickEvent>(_unSaveButtonClickEvent);
    on<LikeEvent>(_likeEvent);
    on<UnLikeEvent>(_unLikeEvent);
    on<CommentButtonClickEvent>(_commentButtonClickEvent);
    on<AddNewCommentEvent>(_addNewCommentEvent);
    on<DeleteCommentEvent>(_deleteCommentEvent);
  }

  FutureOr<void> _featchAllFollowingPostEvent(
    FeatchAllFollowingPostEvent event,
    Emitter<FollowingPostState> emit,
  ) async {
    emit(FeatchFollowingPostLoadingState());
    final responce = await PostRepo.getFollowersPost(page: 1);
    if (responce != null) {
      final responseBody = jsonDecode(responce.body);
      // log(responseBody.toString());
      final List<PostModel> posts = await responseBody
          .map<PostModel>(
            (json) => PostModel.fromJson(json),
          )
          .toList();
      emit(FeatchFollowingPostSuccessState(posts: posts));
    }
  }

  FutureOr<void> _saveButtonClickEvent(
    SaveButtonClickEvent event,
    Emitter<FollowingPostState> emit,
  ) async {
    emit(SavePostLoadingState());

    Response? saveResponce = await PostRepo.savePost(postId: event.post.id);
    final postListResponce = await PostRepo.getFollowersPost(page: 1);
    if (saveResponce != null && saveResponce.body.isNotEmpty) {
      final saveResponceBody = jsonDecode(saveResponce.body);
      switch (saveResponce.statusCode) {
        case 200:
          if (postListResponce != null && postListResponce.body.isNotEmpty) {
            final postListresponcBody = jsonDecode(postListResponce.body);
            // log(responseBody.toString());
            final List<PostModel> posts = await postListresponcBody
                .map<PostModel>(
                  (json) => PostModel.fromJson(json),
                )
                .toList();
            emit(FeatchFollowingPostSuccessState(posts: posts));
            // emit(SavePostSuccessState(postId: saveResponceBody["postId"]));
          } else {
            emit(SavePostErrorState(error: "No response received from server"));
          }
          break;
        case 400:
          emit(SavePostErrorState(
              error: "Bad request - ${saveResponceBody["message"]}"));
          break;
        case 401:
          emit(SavePostErrorState(
              error: "Unauthorized - ${saveResponceBody["message"]}"));
          break;
        case 403:
          emit(SavePostErrorState(
              error: "Forbidden - ${saveResponceBody["message"]}"));
          break;
        case 404:
          emit(SavePostErrorState(
              error: "Not found - ${saveResponceBody["message"]}"));
          break;
        case 500:
          emit(SavePostErrorState(
              error: "Internal server error - ${saveResponceBody["message"]}"));
          break;
        default:
          emit(SavePostErrorState(
              error: "HTTP Error - ${saveResponceBody["message"]}"));
          break;
      }
    } else {
      emit(SavePostErrorState(error: "No response received from server"));
    }
  }

  FutureOr<void> _unSaveButtonClickEvent(
    UnSaveButtonClickEvent event,
    Emitter<FollowingPostState> emit,
  ) async {
    emit(SavePostLoadingState());
    Response? saveResponce =
        await PostRepo.removeSavedPost(postId: event.post.id);
    final postListresponc = await PostRepo.getFollowersPost(page: 1);
    if (saveResponce != null && saveResponce.body.isNotEmpty) {
      final saveResponceBody = jsonDecode(saveResponce.body);
      switch (saveResponce.statusCode) {
        case 200:
          if (postListresponc != null && postListresponc.body.isNotEmpty) {
            final postlistBody = jsonDecode(postListresponc.body);
            // log(responseBody.toString());
            final List<PostModel> posts = await postlistBody
                .map<PostModel>(
                  (json) => PostModel.fromJson(json),
                )
                .toList();
            emit(FeatchFollowingPostSuccessState(posts: posts));
            // emit(SavePostSuccessState(postId: saveResponceBody["postId"]));
          } else {
            emit(SavePostErrorState(error: "No response received from server"));
          }
          break;
        case 400:
          emit(SavePostErrorState(
              error: "Bad request - ${saveResponceBody["message"]}"));
          break;
        case 401:
          emit(SavePostErrorState(
              error: "Unauthorized - ${saveResponceBody["message"]}"));
          break;
        case 403:
          emit(SavePostErrorState(
              error: "Forbidden - ${saveResponceBody["message"]}"));
          break;
        case 404:
          emit(SavePostErrorState(
              error: "Not found - ${saveResponceBody["message"]}"));
          break;
        case 500:
          emit(SavePostErrorState(
              error: "Internal server error - ${saveResponceBody["message"]}"));
          break;
        default:
          emit(SavePostErrorState(
              error: "HTTP Error - ${saveResponceBody["message"]}"));
          break;
      }
    } else {
      emit(SavePostErrorState(error: "No response received from server"));
    }
  }

  FutureOr<void> _likeEvent(
    LikeEvent event,
    Emitter<FollowingPostState> emit,
  ) async {
    emit(LikeLoadingState());
    final Response? likeResponce =
        await PostRepo.likePost(postId: event.post.id);
    final postListresponc = await PostRepo.getFollowersPost(page: 1);
    if (likeResponce != null && likeResponce.body.isNotEmpty) {
      final likeResponceBody = jsonDecode(likeResponce.body);
      switch (likeResponce.statusCode) {
        case 200:
          if (postListresponc != null && postListresponc.body.isNotEmpty) {
            final postlistBody = jsonDecode(postListresponc.body);
            // log(responseBody.toString());
            final List<PostModel> posts = await postlistBody
                .map<PostModel>(
                  (json) => PostModel.fromJson(json),
                )
                .toList();
            emit(FeatchFollowingPostSuccessState(posts: posts));
            // emit(SavePostSuccessState(postId: saveResponceBody["postId"]));
          } else {
            emit(SavePostErrorState(error: "No response received from server"));
          }
          break;
        case 400:
          emit(SavePostErrorState(
              error: "Bad request - ${likeResponceBody["message"]}"));
          break;
        case 401:
          emit(SavePostErrorState(
              error: "Unauthorized - ${likeResponceBody["message"]}"));
          break;
        case 403:
          emit(SavePostErrorState(
              error: "Forbidden - ${likeResponceBody["message"]}"));
          break;
        case 404:
          emit(SavePostErrorState(
              error: "Not found - ${likeResponceBody["message"]}"));
          break;
        case 500:
          emit(SavePostErrorState(
              error: "Internal server error - ${likeResponceBody["message"]}"));
          break;
        default:
          emit(SavePostErrorState(
              error: "HTTP Error - ${likeResponceBody["message"]}"));
          break;
      }
    } else {
      emit(SavePostErrorState(error: "No response received from server"));
    }
  }

  FutureOr<void> _unLikeEvent(
    UnLikeEvent event,
    Emitter<FollowingPostState> emit,
  ) async {
    emit(LikeLoadingState());
    final Response? unLikeResponce =
        await PostRepo.unlikePost(postId: event.post.id);
    final postListresponc = await PostRepo.getFollowersPost(page: 1);
    if (unLikeResponce != null && unLikeResponce.body.isNotEmpty) {
      final unLikeResponceBody = jsonDecode(unLikeResponce.body);
      switch (unLikeResponce.statusCode) {
        case 200:
          if (postListresponc != null && postListresponc.body.isNotEmpty) {
            final postlistBody = jsonDecode(postListresponc.body);
            // log(responseBody.toString());
            final List<PostModel> posts = await postlistBody
                .map<PostModel>(
                  (json) => PostModel.fromJson(json),
                )
                .toList();
            emit(FeatchFollowingPostSuccessState(posts: posts));
            // emit(SavePostSuccessState(postId: saveResponceBody["postId"]));
          } else {
            emit(SavePostErrorState(error: "No response received from server"));
          }
          break;
        case 400:
          emit(SavePostErrorState(
              error: "Bad request - ${unLikeResponceBody["message"]}"));
          break;
        case 401:
          emit(SavePostErrorState(
              error: "Unauthorized - ${unLikeResponceBody["message"]}"));
          break;
        case 403:
          emit(SavePostErrorState(
              error: "Forbidden - ${unLikeResponceBody["message"]}"));
          break;
        case 404:
          emit(SavePostErrorState(
              error: "Not found - ${unLikeResponceBody["message"]}"));
          break;
        case 500:
          emit(SavePostErrorState(
              error:
                  "Internal server error - ${unLikeResponceBody["message"]}"));
          break;
        default:
          emit(SavePostErrorState(
              error: "HTTP Error - ${unLikeResponceBody["message"]}"));
          break;
      }
    } else {
      emit(SavePostErrorState(error: "No response received from server"));
    }
  }

  FutureOr<void> _commentButtonClickEvent(
    CommentButtonClickEvent event,
    Emitter<FollowingPostState> emit,
  ) async {
    emit(FeatchCommentsLoadingState());
    final Response? commentResponce =
        await PostRepo.getAllComments(postId: event.post.id);
    if (commentResponce != null && commentResponce.body.isNotEmpty) {
      // log(commentResponce.body.toString());
      final commentResponceBody = jsonDecode(commentResponce.body);
      switch (commentResponce.statusCode) {
        case 200:
          // log(commentResponceBody.toString());
          List<CommentModel> comments = (commentResponceBody['comments']
                  as List<dynamic>)
              .map(
                  (json) => CommentModel.fromJson(json as Map<String, dynamic>))
              .toList();
          emit(FeatchCommentsSuccessState(comments: comments));

          // log(comments.toString());
          break;
        case 400:
          emit(SavePostErrorState(
              error: "Bad request - ${commentResponceBody["message"]}"));
          break;
        case 401:
          emit(SavePostErrorState(
              error: "Unauthorized - ${commentResponceBody["message"]}"));
          break;
        case 403:
          emit(SavePostErrorState(
              error: "Forbidden - ${commentResponceBody["message"]}"));
          break;
        case 404:
          emit(SavePostErrorState(
              error: "Not found - ${commentResponceBody["message"]}"));
          break;
        case 500:
          emit(SavePostErrorState(
              error:
                  "Internal server error - ${commentResponceBody["message"]}"));
          break;
        default:
          emit(SavePostErrorState(
              error: "HTTP Error - ${commentResponceBody["message"]}"));
          break;
      }
    } else {
      emit(SavePostErrorState(error: "No response received from server"));
    }
  }

  FutureOr<void> _addNewCommentEvent(
    AddNewCommentEvent event,
    Emitter<FollowingPostState> emit,
  ) async {
    emit(AddNewCommentLoadingState());
    final Response? commentResponce = await PostRepo.commentPost(
      postId: event.post.id,
      userName: event.post.userId.userName??"no",
      content: event.comment,
    );
    if (commentResponce != null && commentResponce.body.isNotEmpty) {
      final commentResponceBody = jsonDecode(commentResponce.body);
      switch (commentResponce.statusCode) {
        case 200:
          final Response? featchCommentResponce =
              await PostRepo.getAllComments(postId: event.post.id);
          if (featchCommentResponce != null &&
              featchCommentResponce.body.isNotEmpty &&
              featchCommentResponce.statusCode == 200) {
            // log(commentResponce.body.toString());
            final featchCommentResponceBody =
                jsonDecode(featchCommentResponce.body);
            List<CommentModel> comments =
                (featchCommentResponceBody['comments'] as List<dynamic>)
                    .map((json) =>
                        CommentModel.fromJson(json as Map<String, dynamic>))
                    .toList();
            emit(FeatchCommentsSuccessState(comments: comments));
          } else {
            emit(AddNewCommentErrorState(
                error: "No response received from server"));
          }
          // // log(commentResponceBody.toString());
          // List<CommentModel> comments = (commentResponceBody['comments']
          //         as List<dynamic>)
          //     .map(
          //         (json) => CommentModel.fromJson(json as Map<String, dynamic>))
          //     .toList();
          // emit(FeatchCommentsSuccessState(comments: comments));

          // log(comments.toString());
          break;
        case 400:
          emit(AddNewCommentErrorState(
              error: "Bad request - ${commentResponceBody["message"]}"));
          break;
        case 401:
          emit(AddNewCommentErrorState(
              error: "Unauthorized - ${commentResponceBody["message"]}"));
          break;
        case 403:
          emit(AddNewCommentErrorState(
              error: "Forbidden - ${commentResponceBody["message"]}"));
          break;
        case 404:
          emit(AddNewCommentErrorState(
              error: "Not found - ${commentResponceBody["message"]}"));
          break;
        case 500:
          emit(AddNewCommentErrorState(
              error:
                  "Internal server error - ${commentResponceBody["message"]}"));
          break;
        default:
          emit(AddNewCommentErrorState(
              error: "HTTP Error - ${commentResponceBody["message"]}"));
          break;
      }
    }
  }

  FutureOr<void> _deleteCommentEvent(
    DeleteCommentEvent event,
    Emitter<FollowingPostState> emit,
  ) async {
    emit(DeleteCommentLoadingState());
    final Response? deleteResponce =
        await PostRepo.deleteComment(commentId: event.comment.id);
    if (deleteResponce != null && deleteResponce.body.isNotEmpty) {
      final deleteResponceBody = jsonDecode(deleteResponce.body);
      switch (deleteResponce.statusCode) {
        case 200:
          final Response? featchCommentResponce =
              await PostRepo.getAllComments(postId: event.post.id);
          if (featchCommentResponce != null &&
              featchCommentResponce.body.isNotEmpty &&
              featchCommentResponce.statusCode == 200) {
            // log(commentResponce.body.toString());
            final featchCommentResponceBody =
                jsonDecode(featchCommentResponce.body);
            List<CommentModel> comments =
                (featchCommentResponceBody['comments'] as List<dynamic>)
                    .map((json) =>
                        CommentModel.fromJson(json as Map<String, dynamic>))
                    .toList();
            emit(FeatchCommentsSuccessState(comments: comments));
          }else{
            emit(DeleteCommentErrorState(
                error: "No response received from server"));
          }
          break;
        case 400:
          emit(AddNewCommentErrorState(
              error: "Bad request - ${deleteResponceBody["message"]}"));
          break;
        case 401:
          emit(AddNewCommentErrorState(
              error: "Unauthorized - ${deleteResponceBody["message"]}"));
          break;
        case 403:
          emit(AddNewCommentErrorState(
              error: "Forbidden - ${deleteResponceBody["message"]}"));
          break;
        case 404:
          emit(AddNewCommentErrorState(
              error: "Not found - ${deleteResponceBody["message"]}"));
          break;
        case 500:
          emit(AddNewCommentErrorState(
              error:
                  "Internal server error - ${deleteResponceBody["message"]}"));
          break;
        default:
          emit(AddNewCommentErrorState(
              error: "HTTP Error - ${deleteResponceBody["message"]}"));
          break;
      }
    }
  }
}
