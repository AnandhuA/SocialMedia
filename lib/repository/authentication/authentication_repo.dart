import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:social_media/core/urls.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/repository/authentication/shared_preferences.dart';

class AuthenticationRepo {
  static Future<http.Response?> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, String> user = {
        'email': email,
        'password': password,
      };
      http.Response response = await http.post(Uri.parse(baseurl + loginurl),
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

  static Future<http.Response?> userSignUp(
      {required UserModel userModel}) async {
    Map<String, String> data = {
      "userName": userModel.userName,
      "email": userModel.email,
      "password": userModel.password,
    };
    try {
      http.Response responcse = await http
          .post(Uri.parse(baseurl + signup), body: jsonEncode(data), headers: {
        "Content-Type": "application/json",
      });
      return responcse;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<http.Response?> otpVerification({
    required String email,
    required String otp,
  }) async {
    Map<String, String> data = {
      "email": email,
      "otp": otp,
    };
    try {
      http.Response response = await http
          .post(Uri.parse(baseurl + otpurl), body: jsonEncode(data), headers: {
        "Content-Type": "application/json",
      });
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<http.Response?> forgotPassword({required String email}) async {
    try {
      http.Response response =
          await http.get(Uri.parse("${baseurl + forgotPasswordurl}$email"));
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<http.Response?> verifyOtpForgotPassword({
    required String email,
    required String otp,
  }) async {
    try {
      http.Response response = await http
          .get(Uri.parse('${baseurl + verifyOtpReset}$email&otp=$otp'));

      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response?> setNewPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = {'email': email, 'password': password};
      http.Response response = await http.patch(
          Uri.parse(baseurl + updatePasswordurl),
          body: jsonEncode(user),
          headers: {"Content-Type": 'application/json'});

      return response;
    } catch (e) {
      return null;
    }
  }
}
