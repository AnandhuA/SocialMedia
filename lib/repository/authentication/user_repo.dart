import 'package:http/http.dart' as http;
import 'package:social_media/core/urls.dart';
import 'package:social_media/repository/authentication/shared_preferences.dart';

class UserRepo {
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

  //fetchsuggession user
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
  
}
