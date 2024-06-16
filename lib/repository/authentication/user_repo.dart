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
}
