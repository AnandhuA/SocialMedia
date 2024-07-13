import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/main.dart';

const String authKey = "AUTHKEY";
const String tokenKey = "TOKEN";
const String id = "USERID";
const String userNamekey = "USERNAME";
const String userProfilePickey = "USERPROFILEPIC";

//------set login cerdentional in sharedprefernes---------
setUserLoggedin({
  required String token,
  required String userid,
  required String userName,
  required String userprofilePic,
}) async {
  final sharedPref = await SharedPreferences.getInstance();
  await sharedPref.setBool(authKey, true);
  await sharedPref.setString(tokenKey, token);
  await sharedPref.setString(id, userid);
  await sharedPref.setString(userNamekey, userName);
  await sharedPref.setString(userProfilePickey, userprofilePic);

  userProfilePic = await getUserProfilePic() ??
      "https://res.cloudinary.com/di9yf5j0d/image/upload/v1695795823/om0qyogv6dejgjseakej.png";
  userName = await getUserName() ?? "";
  userId = await getUserId() ?? "Anonymous";
}

//--------clear cerdentional-------
clearUserSession() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final sharedprefs = await SharedPreferences.getInstance();
  await sharedprefs.remove(authKey);
  await sharedprefs.remove(tokenKey);
  await sharedprefs.remove(id);
  await sharedprefs.remove(userNamekey);
  await sharedprefs.remove(userProfilePickey);
  await googleSignIn.signOut();
}

//----get user token-------
Future<String?> getUsertoken() async {
  final sharedpreference = await SharedPreferences.getInstance();
  final token = sharedpreference.getString(tokenKey);
  return token;
}

//----------get user id-----------
Future<String?> getUserId() async {
  final sharedpreference = await SharedPreferences.getInstance();
  final userid = sharedpreference.getString(id);
  return userid;
}

//----------get userprofilePic-----------
Future<String?> getUserProfilePic() async {
  final sharedpreference = await SharedPreferences.getInstance();
  final userid = sharedpreference.getString(userProfilePickey);
  return userid;
}

//----------get user name-----------
Future<String?> getUserName() async {
  final sharedpreference = await SharedPreferences.getInstance();
  final userid = sharedpreference.getString(userNamekey);
  return userid;
}
//----------Change profilepic-----------

Future<void> changeProfilePic(String profilePic) async {
  final sharedpreference = await SharedPreferences.getInstance();
  await sharedpreference.setString(userProfilePickey, profilePic);
}
