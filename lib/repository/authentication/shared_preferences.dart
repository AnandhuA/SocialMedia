import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String authKey = "AUTHKEY";
const String tokenKey = "TOKEN";
const String userId = "USERID";
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
  await sharedPref.setString(userId, userid);
  await sharedPref.setString(userNamekey, userName);
  await sharedPref.setString(userProfilePickey, userprofilePic);
}

//--------clear cerdentional-------
clearUserSession() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final sharedprefs = await SharedPreferences.getInstance();
  await sharedprefs.remove(authKey);
  await sharedprefs.remove(tokenKey);
  await sharedprefs.remove(userId);
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
  final userid = sharedpreference.getString(userId);
  return userid;
}

//----------get userprofilePic-----------
Future<String?> getUserProfilePic() async {
  final sharedpreference = await SharedPreferences.getInstance();
  final userid = sharedpreference.getString(userProfilePickey);
  return userid;
}
