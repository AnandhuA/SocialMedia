class _User {
  String id;
  String userName;
  String email;
  String
      password; // Note: This should typically be handled securely, not stored in plain text
  String profilePic;
  String phone;
  bool online;
  bool blocked;
  bool verified;
  String role;
  bool isPrivate;
  String backGroundImage;
  DateTime createdAt;
  DateTime updatedAt;
  String bio;
  String name;

  _User({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.phone,
    required this.online,
    required this.blocked,
    required this.verified,
    required this.role,
    required this.isPrivate,
    required this.backGroundImage,
    required this.createdAt,
    required this.updatedAt,
    required this.bio,
    required this.name,
  });

  factory _User.fromJson(Map<String, dynamic> json) {
    return _User(
      id: json['_id'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      profilePic: json['profilePic'] ?? '',
      phone: json['phone'] ?? '',
      online: json['online'] ?? false,
      blocked: json['blocked'] ?? false,
      verified: json['verified'] ?? false,
      role: json['role'] ?? '',
      isPrivate: json['isPrivate'] ?? false,
      backGroundImage: json['backGroundImage'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      bio: json['bio'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class SavePostModel {
  String userId;
  String postId;
  _User user;
  String image;
  String description;
  List<String> likes;
  bool hidden;
  bool blocked;
  List<dynamic> tags;
  List<dynamic> taggedUsers;
  int commentCount;
  DateTime createdAt;
  DateTime updatedAt;

  SavePostModel({
    required this.userId,
    required this.postId,
    required this.user,
    required this.image,
    required this.description,
    required this.likes,
    required this.hidden,
    required this.blocked,
    required this.tags,
    required this.taggedUsers,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SavePostModel.fromJson(Map<String, dynamic> json) {
    return SavePostModel(
      userId: json['userId'] ?? '',
      postId: json['postId']['_id'] ?? '',
      user: _User.fromJson(json['postId']['userId'] ?? {}),
      image: json['postId']['image'] ?? '',
      description: json['postId']['description'] ?? '',
      likes: List<String>.from(json['postId']['likes'] ?? []),
      hidden: json['postId']['hidden'] ?? false,
      blocked: json['postId']['blocked'] ?? false,
      tags: List<dynamic>.from(json['postId']['tags'] ?? []),
      taggedUsers: List<dynamic>.from(json['postId']['taggedUsers'] ?? []),
      commentCount: json['postId']['commentCount'] as int,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }
}
