class UserModel {
  final String userName;
  final String id;
  final String? email;
  final String? password;
  final String? profilePic;
  final bool? online;
  final bool? blocked;
  final bool? verified;
  final String? role;
  final bool? isPrivate;
  final String? backGroundImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? bio;
  final String? phone;

  UserModel({
    required this.id,
    required this.userName,
    this.email,
    this.password,
    this.profilePic,
    this.phone,
    this.online,
    this.blocked,
    this.verified,
    this.role,
    this.isPrivate,
    this.backGroundImage,
    this.createdAt,
    this.updatedAt,
    this.bio,
    this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
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
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      bio: json['bio'],
      name: json['name'],
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
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'bio': bio,
      'name': name,
    };
  }
}
