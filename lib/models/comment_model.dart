import 'package:social_media/models/user_model.dart';

class CommentModel {
  final String id;
  final UserModel userId;
  final String postId;
  final String userName;
  final String content;
  final bool deleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int repliesCount;

  CommentModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.userName,
    required this.content,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.repliesCount,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'] as String,
      userId: UserModel.fromJson(json['userId'] as Map<String, dynamic>),
      postId: json['postId'] as String,
      userName: json['userName'] as String,
      content: json['content'] as String,
      deleted: json['deleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      repliesCount: json['repliesCount'] as int,
    );
  }
}
