class User {
  final String id;
  final String userName;
  final String email;
  final String password;
  final String profilePic;
  final String phone;
  final bool online;
  final bool blocked;
  final bool verified;
  final String role;
  final bool isPrivate;
  final String backGroundImage;
  final DateTime createdAt;
  final DateTime updatedAt;

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
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      profilePic: json['profilePic'] as String,
      phone: json['phone'] as String,
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
      'phone': phone,
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



// {
//   _id: 6651e3d1f8d690f9dcc81841,
//    userName: akhil, 
//    email: anandhu1407@gmail.com, 
//    password: $2a$10$ahtNXJfeK7ZRr1s6XsXPW.vZxyJsBydml0JoJfdlniXr/7pJ//lne,
//   profilePic: https://res.cloudinary.com/di9yf5j0d/image/upload/v1695795823/om0qyogv6dejgjseakej.png, 
//   phone: 1234567891, 
//   online: false, 
//   blocked: false, 
//   verified: false, 
//   role: User, 
//   isPrivate: false, 
//   backGroundImage: https://img.freepik.com/free-photo/artistic-blurry-colorful-wallpaper-background_58702-8192.jpg?size=626&ext=jpg&ga=GA1.1.1700460183.1712361600&semt=ais, 
//   createdAt: 2024-05-25T13:12:49.277Z, 
//   updatedAt: 2024-06-12T08:14:57.826Z, 
//   __v: 0
//   }