import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:social_media/core/urls.dart';
import 'package:social_media/models/user_model.dart';

class SignupRepo {
  static Future<Response?> userSignUp({required UserModel userModel}) async {
    Map<String, String> data = {
      "userName": userModel.userName,
      "email": userModel.email,
      "password": userModel.password,
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
