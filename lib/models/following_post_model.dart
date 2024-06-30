class User {
  String id;
  String userName;
  String email;
  String password;
  String profilePic;
  String phone;
  bool online;
  bool blocked;
  bool verified;
  String role;
  bool isPrivate;
  String backGroundImage;
  String createdAt;
  String updatedAt;
  int v;
  String bio;
  String name;

  User({
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
    required this.v,
    required this.bio,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      profilePic: json['profilePic'],
      phone: json['phone'],
      online: json['online'],
      blocked: json['blocked'],
      verified: json['verified'],
      role: json['role'],
      isPrivate: json['isPrivate'],
      backGroundImage: json['backGroundImage'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      bio: json['bio'],
      name: json['name'],
    );
  }
}

class Like {
  String id;
  String userName;
  String email;
  String profilePic;
  String phone;
  bool online;
  bool blocked;
  bool verified;
  String role;
  bool isPrivate;
  String backGroundImage;
  String createdAt;
  String updatedAt;
  int v;
  String bio;
  String name;

  Like({
    required this.id,
    required this.userName,
    required this.email,
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
    required this.v,
    required this.bio,
    required this.name,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      profilePic: json['profilePic'],
      phone: json['phone'],
      online: json['online'],
      blocked: json['blocked'],
      verified: json['verified'],
      role: json['role'],
      isPrivate: json['isPrivate'],
      backGroundImage: json['backGroundImage'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      bio: json['bio'],
      name: json['name'],
    );
  }
}

class Post {
  String id;
  User userId;
  String image;
  String description;
  List<Like> likes;
  bool hidden;
  bool blocked;
  List<dynamic> tags; // You can replace `dynamic` with the actual type of tags
  List<dynamic>
      taggedUsers; // You can replace `dynamic` with the actual type of taggedUsers
  int commentCount;
  String date;
  String edited;
  String createdAt;
  String updatedAt;
  int v;
  bool isLiked;
  bool isSaved;

  Post({
    required this.id,
    required this.userId,
    required this.image,
    required this.description,
    required this.likes,
    required this.hidden,
    required this.blocked,
    required this.tags,
    required this.taggedUsers,
    required this.commentCount,
    required this.date,
    required this.edited,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isLiked,
    required this.isSaved,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      userId: User.fromJson(json['userId']),
      image: json['image'],
      description: json['description'],
      likes: (json['likes'] as List<dynamic>)
          .map((likeJson) => Like.fromJson(likeJson))
          .toList(),
      hidden: json['hidden'],
      blocked: json['blocked'],
      tags: json['tags'],
      taggedUsers: json['taggedUsers'],
      commentCount: json['commentCount'],
      date: json['date'],
      edited: json['edited'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      isLiked: json['isLiked'],
      isSaved: json['isSaved'],
    );
  }
}
