import 'package:shared_preferences/shared_preferences.dart';

const String authKey = "AUTHKEY";
const String tokenKey = "TOKEN";

setUserLoggedin({required String token}) async {
  final sharedPref = await SharedPreferences.getInstance();
  await sharedPref.setBool(authKey, true);
  await sharedPref.setString(tokenKey, token);
}
