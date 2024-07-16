import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:social_media/core/urls.dart';
import 'package:social_media/repository/authentication/shared_preferences.dart';

class ChatRepo {
//---------------Create conversation----------------
  static Future<http.Response?> createConversation({
    required List<String> members,
  }) async {
    try {
      final token = await getUsertoken();
      final body = {"members": members};
      final http.Response response = await http.post(
          Uri.parse('$baseurl$createconversationurl'),
          body: jsonEncode(body),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': "application/json"
          });
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

//---------------get all conversations-------------
  static Future<http.Response?> getAllConversations() async {
    try {
      final token = await getUsertoken();
      final http.Response response = await http.get(
          Uri.parse('$baseurl$getconversationurl'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

//--------------Add message-------------
  static Future<http.Response?> addMessage({
    required String recieverId,
    required String text,
    required String conversationId,
    required String senderId,
  }) async {
    try {
      final token = await getUsertoken();
      final body = {
        "senderId": senderId,
        "conversationId": conversationId,
        "text": text,
        "recieverId": recieverId
      };
      final http.Response response = await http.post(
          Uri.parse('$baseurl$addmessageurl'),
          body: jsonEncode(body),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": 'application/json'
          });
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

//-----------get all Messages----------------
  static Future<http.Response?> getAllMessages({
    required String conversationId,
  }) async {
    try {
      final token = await getUsertoken();
      final http.Response response = await http.get(
          Uri.parse('$baseurl$getallmessageurl/$conversationId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
