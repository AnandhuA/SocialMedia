import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_media/core/urls.dart';
import 'package:social_media/repository/authentication/shared_preferences.dart';

class UserRepo {
  //-------------fetch user details-----------------
  static Future<http.Response?> fetchLoggedInUserDetails() async {
    try {
      final token = await getUsertoken();
      var response = await http.get(Uri.parse(baseurl + loginuserurl),
          headers: {'Authorization': 'Bearer $token'});

      return response;
    } catch (e) {
      return null;
    }
  }

//---------------fetch count of following and follower---------
  static Future<http.Response?> fetchCount() async {
    try {
      final token = await getUsertoken();
      final userid = await getUserId();
      var response = http.get(Uri.parse("$baseurl$connectioncounturl/$userid"),
          headers: {'Authorization': 'Bearer $token'});

      return response;
    } catch (e) {
      return null;
    }
  }

  //----------fetchsuggession user------------------
  static Future<http.Response?> fetchSuggessionUser() async {
    try {
      final token = await getUsertoken();
      var response = http.get(Uri.parse('$baseurl$suggessionurl'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      return null;
    }
  }

//--------------edit user profile----------------
  static Future<http.Response?> editProfile({
    required String name,
    required String bio,
    required String coverPhoto,
    required String profilePhoto,
  }) async {
    try {
      final token = await getUsertoken();
      final details = {
        "name": name,
        "bio": bio,
        "image": profilePhoto,
        "backGroundImage": coverPhoto,
      };
      var response = await http.put(Uri.parse('$baseurl$editprofileurl'),
          body: jsonEncode(details),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });

      return response;
    } catch (e) {
      return null;
    }
  }

}
