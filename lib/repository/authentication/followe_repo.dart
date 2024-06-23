import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:social_media/core/urls.dart';
import 'package:social_media/repository/authentication/shared_preferences.dart';

class FolloweRepo {
  //fetch followers
  static Future<http.Response?> fetchFollowers() async {
    try {
      final token = await getUsertoken();
      var response = http.get(Uri.parse('$baseurl$fetchfollowersurl'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  //fetch followers
  static Future<http.Response?> fetchFollowing() async {
    try {
      final token = await getUsertoken();
      var response = http.get(Uri.parse('$baseurl$fetchfollowingurl'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
