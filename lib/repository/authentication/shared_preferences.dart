import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String authKey = "AUTHKEY";
const String tokenKey = "TOKEN";
const String userId = "USERID";

setUserLoggedin({required String token, required String userid}) async {
  final sharedPref = await SharedPreferences.getInstance();
  await sharedPref.setBool(authKey, true);
  await sharedPref.setString(tokenKey, token);
  await sharedPref.setString(userId, userid);
}

clearUserSession() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final sharedprefs = await SharedPreferences.getInstance();
  await sharedprefs.remove(authKey);
  await sharedprefs.remove(tokenKey);
  await googleSignIn.signOut();
}

Future<String?> getUsertoken() async {
  final sharedpreference = await SharedPreferences.getInstance();
  final token = sharedpreference.getString(tokenKey);
  return token;
}

Future<String?> getUserId() async {
  final sharedpreference = await SharedPreferences.getInstance();
  final userid = sharedpreference.getString(userId);
  return userid;
}
