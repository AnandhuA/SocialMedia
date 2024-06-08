import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:social_media/core/urls.dart';
import 'package:social_media/repository/authentication/shared_preferences.dart';

class LoginRepo {

  
  static Future<Response?> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, String> user = {
        'email': email,
        'password': password,
      };
      Response response = await http.post(Uri.parse(baseurl + loginurl),
          body: jsonEncode(user),
          headers: {"Content-Type": 'application/json'});
      log(response.body);

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      log(responseBody.toString());
      if (response.statusCode == 200) {
        await setUserLoggedin(token: responseBody["user"]["token"]);
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
