import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:social_media/core/urls.dart';
import 'package:social_media/models/auth_user_model.dart';
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

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await setUserLoggedin(
          token: responseBody["user"]["token"],
          userid: responseBody['user']['_id'],
        );
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response?> userSignUp(
      {required AuthUserModel userModel}) async {
    Map<String, String> data = {
      "userName": userModel.userName,
      "email": userModel.email,
      "password": userModel.password,
      "phone": userModel.phone,
    };
    try {
      http.Response responcse = await http
          .post(Uri.parse(baseurl + signup), body: jsonEncode(data), headers: {
        "Content-Type": "application/json",
      });
      return responcse;
    } catch (e) {
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
      return null;
    }
  }

  static Future<http.Response?> forgotPassword({required String email}) async {
    try {
      http.Response response =
          await http.get(Uri.parse("${baseurl + forgotPasswordurl}$email"));
      return response;
    } catch (e) {
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

  static Future<UserCredential?> siginWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response?> googleLogin(String email) async {
    try {
      final finalEmail = {'email': email};
      http.Response response = await http.post(
          Uri.parse(baseurl + googleLoginurl),
          body: jsonEncode(finalEmail),
          headers: {"Content-Type": 'application/json'});

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        await setUserLoggedin(
          token: responseBody['user']['token'],
          userid: responseBody['user']['_id'],
        );
      }
      return response;
    } catch (e) {
      return null;
    }
  }
}
