class _UserModel {
  final String id;
  final String userName;
  final String email;
  final String password;
  final String profilePic;
  final bool online;
  final bool blocked;
  final bool verified;
  final String role;
  final bool isPrivate;
  final String backGroundImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  _UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.online,
    required this.blocked,
    required this.verified,
    required this.role,
    required this.isPrivate,
    required this.backGroundImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _UserModel.fromJson(Map<String, dynamic> json) {
    return _UserModel(
      id: json['_id'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      profilePic: json['profilePic'] as String,
      online: json['online'] as bool,
      blocked: json['blocked'] as bool,
      verified: json['verified'] as bool,
      role: json['role'] as String,
      isPrivate: json['isPrivate'] as bool,
      backGroundImage: json['backGroundImage'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userName': userName,
      'email': email,
      'password': password,
      'profilePic': profilePic,
      'online': online,
      'blocked': blocked,
      'verified': verified,
      'role': role,
      'isPrivate': isPrivate,
      'backGroundImage': backGroundImage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}


class PostModel {
  final String id;
  final _UserModel userId;
  final String image;
  final String description;
  final List<String> likes;
  final bool hidden;
  final bool blocked;
  final List<String> tags;
  final List<String> taggedUsers;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

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
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'] as String,
      userId: _UserModel.fromJson(json['userId'] as Map<String, dynamic>),
      image: json['image'] as String,
      description: json['description'] as String,
      likes: List<String>.from(json['likes'] as List),
      hidden: json['hidden'] as bool,
      blocked: json['blocked'] as bool,
      tags: List<String>.from(json['tags'] as List),
      taggedUsers: List<String>.from(json['taggedUsers'] as List),
      date: DateTime.parse(json['date'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
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
    };
  }
}




// [
  // {
  //   "_id":"666c63ac660b629740de0557",
  // "userId":{
  //   "_id":"6664110bda03f495b6ec6d6d",
  //   "userName":"anandhu23",
  //   "email":"anandhuav14@gmail.com",
  //   "password":"$2a$10$iXqkohCNsHD9a9JlRr032OJe9SNxOPm8NtajY.axT5m3OlGx9mmru",
  //   "profilePic":"https://res.cloudinary.com/di9yf5j0d/image/upload/v1695795823/om0qyogv6dejgjseakej.png",
  //   "online":false,
  //   "blocked":false,
  //   "verified":false,
  //   "role":"User",
  //   "isPrivate":false,
  //   "backGroundImage":"https://img.freepik.com/free-photo/artistic-blurry-colorful-wallpaper-background_58702-8192.jpg?size=626&ext=jpg&ga=GA1.1.1700460183.1712361600&semt=ais",
  //   "createdAt":"2024-06-08T08:06:35.408Z",
  //   "updatedAt":"2024-06-08T08:06:35.408Z",
  //   "__v":0
  //   },
  //   "image":"http://res.cloudinary.com/dm27venn4/image/upload/v1718379434/ubfdjagporwolcxgcwuk.jpg",
  //   "description":"Welcome",
  //   "likes":[],
  //   "hidden":false,
  //   "blocked":false,
  //   "tags":[],
  //   "taggedUsers":[],
  //   "date":"2024-06-14T15:37:16.938Z",
  //   "createdAt":"2024-06-14T15:37:16.939Z",
  //   "updatedAt":"2024-06-14T15:37:16.939Z",
  //   "__v":0
  //   },
  //   {
  //     "_id":"666c631c660b629740de0553",
  //   "userId":{
  //     "_id":"6664110bda03f495b6ec6d6d",
  //     "userName":"anandhu23",
  //     "email":"anandhuav14@gmail.com",
  //     "password":"$2a$10$iXqkohCNsHD9a9JlRr032OJe9SNxOPm8NtajY.axT5m3OlGx9mmru",
  //     "profilePic":"https://res.cloudinary.com/di9yf5j0d/image/upload/v1695795823/om0qyogv6dejgjseakej.png",
  //     "online":false,
  //     "blocked":false,
  //     "verified":false,
  //     "role":"User",
  //     "isPrivate":false,
  //     "backGroundImage":"https://img.freepik.com/free-photo/artistic-blurry-colorful-wallpaper-background_58702-8192.jpg?size=626&ext=jpg&ga=GA1.1.1700460183.1712361600&semt=ais",
  //     "createdAt":"2024-06-08T08:06:35.408Z",
  //     "updatedAt":"2024-06-08T08:06:35.408Z",
  //     "__v":0
  //     },
  //     "image":"http://res.cloudinary.com/dm27venn4/image/upload/v1718379289/jnb1jm0eftmh2yyk3sfu.jpg",
  //     "description":"",
  //     "likes":[],
  //     "hidden":false,
  //     "blocked":false,
  //     "tags":[],
  //     "taggedUsers":[],
  //     "date":"2024-06-14T15:34:52.107Z",
  //     "createdAt":"2024-06-14T15:34:52.114Z",
  //     "updatedAt":"2024-06-14T15:34:52.114Z",
  //     "__v":0
  //     }
// ]