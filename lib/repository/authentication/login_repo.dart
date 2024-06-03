import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:social_media/core/urls.dart';

class LoginRepo {
  static Future<Response?> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      var user = {'email': email, 'password': password};
      Response response = await http.post(Uri.parse(baseurl + loginurl),
          body: jsonEncode(user),
          headers: {"Content-Type": 'application/json'});
      log(response.body);

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      log(responseBody.toString());
      if (response.statusCode == 200) {
        // await setUserLoggedin(
        //   token: responseBody['user']['token'],
        //   userrole: responseBody['user']['role'],
        //   userid: responseBody['user']['_id'],
        //   userEmail: responseBody['user']['email'],
        //   userName: responseBody['user']['userName'],
        //   userprofile: responseBody['user']['profilePic'],
        // );
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
