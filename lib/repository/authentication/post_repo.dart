import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:social_media/core/urls.dart';
import 'package:social_media/repository/authentication/shared_preferences.dart';

class PostRepo {
  static Future uploadImage(imagePath) async {
    String filePath = imagePath;
    File file = File(filePath);
    try {
      final url =
          Uri.parse('https://api.cloudinary.com/v1_1/dm27venn4/image/upload');

      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'yzegocze'
        ..files.add(await http.MultipartFile.fromPath('file', file.path));
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        log(jsonMap['url']);
        return jsonMap['url'];
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<http.Response?> addPost(
      String description, String image) async {
    try {
      final imageUrl = await PostRepo.uploadImage(image);
      final userid = await getUserId();
      final token = await getUsertoken();
      final post = {
        'imageUrl': imageUrl,
        'description': description,
        'userId': userid
      };
      var response = await http.post(Uri.parse(baseurl + addposturl),
          body: jsonEncode(post),
          headers: {
            "Content-Type": 'application/json',
            'Authorization': 'Bearer $token'
          });

      return response;
    } catch (e) {
      return null;
    }
  }

//get post
  static Future<http.Response?> fetchPosts() async {
    try {
      final token = await getUsertoken();

      var response = await http.get(Uri.parse(baseurl + fetchposturl),
          headers: {'Authorization': 'Bearer $token'});

      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<http.Response?> deletePost({required String postId}) async {
    try {
      final token = await getUsertoken();
      var response = await http.delete(
          Uri.parse('$baseurl$deleteposturl/$postId'),
          headers: {'Authorization': 'Bearer $token'});

      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response?> editPost({
    required String description,
    required XFile? imgFile,
    required String postId,
    required String? imageUrl,
  }) async {
    String image = "";
    try {
      if (imgFile != null) {
        image = await PostRepo.uploadImage(imgFile.path);
      }
      final token = await getUsertoken();
      final post = {
        'imageUrl': imgFile == null ? imageUrl : image,
        'description': description,
      };
      var response = await http.put(Uri.parse('$baseurl$editposturl/$postId'),
          body: jsonEncode(post),
          headers: {
            "Content-Type": 'application/json',
            'Authorization': 'Bearer $token'
          });

      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<http.Response?> getFollowersPost({required int page}) async {
    try {
      final token = await getUsertoken();
      var response = await http.get(
          Uri.parse('$baseurl$followersposturl?page=$page&pageSize=5'),
          headers: {'Authorization': 'Bearer $token'});

      return response;
    } catch (e) {
      return null;
    }
  }

  //fetch explore post
  static Future<http.Response?> fetchExplorePosts() async {
    try {
      final token = await getUsertoken();
      var response = await http.get(Uri.parse('$baseurl$exploreposturl'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      return null;
    }
  }
}
