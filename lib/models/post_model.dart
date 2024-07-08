import 'package:social_media/models/user_model.dart';

// class _UserModel {
//   final String id;
//   final String userName;
//   final String email;
//   final String password;
//   final String profilePic;
//   final bool online;
//   final bool blocked;
//   final bool verified;
//   final String role;
//   final bool isPrivate;
//   final String backGroundImage;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   _UserModel({
//     required this.id,
//     required this.userName,
//     required this.email,
//     required this.password,
//     required this.profilePic,
//     required this.online,
//     required this.blocked,
//     required this.verified,
//     required this.role,
//     required this.isPrivate,
//     required this.backGroundImage,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory _UserModel.fromJson(Map<String, dynamic> json) {
//     return _UserModel(
//       id: json['_id'] as String,
//       userName: json['userName'] as String,
//       email: json['email'] as String,
//       password: json['password'] as String,
//       profilePic: json['profilePic'] as String,
//       online: json['online'] as bool,
//       blocked: json['blocked'] as bool,
//       verified: json['verified'] as bool,
//       role: json['role'] as String,
//       isPrivate: json['isPrivate'] as bool,
//       backGroundImage: json['backGroundImage'] as String,
//       createdAt: DateTime.parse(json['createdAt'] as String),
//       updatedAt: DateTime.parse(json['updatedAt'] as String),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'userName': userName,
//       'email': email,
//       'password': password,
//       'profilePic': profilePic,
//       'online': online,
//       'blocked': blocked,
//       'verified': verified,
//       'role': role,
//       'isPrivate': isPrivate,
//       'backGroundImage': backGroundImage,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }

class PostModel {
  final String id;
  final UserModel userId;
  final String image;
  final String description;
  final List<dynamic> likes;
  final bool hidden;
  final bool blocked;
  final List<String> tags;
  final List<String> taggedUsers;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int commentCount;
  final bool isLiked;
  final bool isSaved;

  PostModel({
    required this.id,
    required this.userId,
    required this.image,
    required this.description,
    required this.likes,
    required this.hidden,
    required this.blocked,
    required this.tags,
    required this.taggedUsers,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.commentCount,
    required this.isLiked,
    required this.isSaved,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> likesData = json['likes'] as List<dynamic>;

    // Determine the type of the items in the likes list
    List<dynamic> parsedLikes;
    if (likesData.isNotEmpty && likesData.first is Map<String, dynamic>) {
      parsedLikes = likesData
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      parsedLikes = List<String>.from(likesData);
    }
    return PostModel(
      id: json['_id'] as String,
      userId: UserModel.fromJson(json['userId'] as Map<String, dynamic>),
      image: json['image'] as String,
      description: json['description'] as String,
      // likes: (json['likes'] as List<dynamic>)
      //     .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
      //     .toList(),
      // likes: List<String>.from(json['likes'] as List),
      likes: parsedLikes,

      hidden: json['hidden'] as bool,
      blocked: json['blocked'] as bool,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(), // Ensure tags are converted to String
      taggedUsers: (json['taggedUsers'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      // tags: List<String>.from(json['tags'] as List),
      // taggedUsers: List<String>.from(json['taggedUsers'] as List),
      date: DateTime.parse(json['date'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      commentCount: json['commentCount'] as int,
      isLiked: json['isLiked'] ?? false,
      isSaved: json['isSaved'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId.toJson(),
      'image': image,
      'description': description,
      'likes': likes,
      'hidden': hidden,
      'blocked': blocked,
      'tags': tags,
      'taggedUsers': taggedUsers,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'commentCount': commentCount,
      'isLiked': isLiked,
      'isSaved': isSaved,
    };
  }
}
