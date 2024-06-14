class UserModel {
  final String userName;
  final String email;
  final String phone;
  final String password;
  String profilePic;
  String bacgroundImage;

  UserModel({
    this.profilePic = "",
   this.bacgroundImage = "",
    required this.userName,
    required this.email,
    required this.phone,
    required this.password,
  });
}
