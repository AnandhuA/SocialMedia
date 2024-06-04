import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:social_media/core/urls.dart';

class SignupRepo {
  static Future<Response?> userSignUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    Map<String, String> data = {
      "userName": name,
      "email": email,
      "password": password,
      "phone": phone,
    };
    try {
      Response responcse = await post(Uri.parse(baseurl + signup),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
          });
      return responcse;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<Response?> otpVerification({
    required String email,
    required String otp,
  }) async {
    Map<String, String> data = {
      "email": email,
      "otp": otp,
    };
    try {
      Response response = await post(Uri.parse(baseurl + otpurl),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
          });
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
