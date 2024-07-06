import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:social_media/core/urls.dart';
import 'package:social_media/repository/authentication/shared_preferences.dart';

class PostRepo {

  //----------------upload image--------------
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

        return jsonMap['url'];
      }
    } catch (e) {
      return e.toString();
    }
  }

//-----------------add post------------------
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

//----------------get post------------------------
  static Future<http.Response?> fetchPosts() async {
    try {
      final token = await getUsertoken();

      var response = await http.get(Uri.parse(baseurl + fetchposturl),
          headers: {'Authorization': 'Bearer $token'});

      return response;
    } catch (e) {
      return null;
    }
  }

//----------------------delete post---------------------------
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

//-------------edit post------------------
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
      return null;
    }
  }

//------------------get followers post------------------------------
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

  //-----------------fetch explore post-------------------
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

  //-------------comment post-------------
  static Future<http.Response?> commentPost({
    required String postId,
    required String userName,
    required String content,
  }) async {
    try {
      final userId = await getUserId();
      final token = await getUsertoken();
      final comment = {
        'userId': userId,
        'userName': userName,
        'postId': postId,
        'content': content
      };
      http.Response response = await http.post(
          Uri.parse('$baseurl$addcommenturl/$postId'),
          body: jsonEncode(comment),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });

      return response;
    } catch (e) {
      return null;
    }
  }

  //------------------Get All comments-------------------------
  static Future<http.Response?> getAllComments({required String postId}) async {
    try {
      final token = await getUsertoken();
      http.Response response = await http.get(
          Uri.parse('$baseurl$fetchcommentsurl/$postId'),
          headers: {'Authorization': 'Bearer $token'});

      return response;
    } catch (e) {
      return null;
    }
  }

//--------------Delete comment----------------
  static Future<http.Response?> deleteComment(
      {required String commentId}) async {
    try {
      final token = await getUsertoken();
      http.Response response = await http.delete(
          Uri.parse('$baseurl$deletecommenturl/$commentId'),
          headers: {'Authorization': 'Bearer $token'});

      return response;
    } catch (e) {
      return null;
    }
  }

  //---------------Like post----------------------------
  static Future<http.Response?> likePost({required String postId}) async {
    try {
      final token = await getUsertoken();
      http.Response response = await http.patch(
          Uri.parse('$baseurl$postlikeurl/$postId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      return null;
    }
  }

//----------------------unlike post-------------------
  static Future<http.Response?> unlikePost({required String postId}) async {
    try {
      final token = await getUsertoken();
      http.Response response = await http.patch(
          Uri.parse('$baseurl$postunlikeurl/$postId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      return null;
    }
  }

  //---------------------save post-----------------
  static Future<http.Response?> savePost({required String postId}) async {
    try {
      final token = await getUsertoken();
      http.Response response = await http.post(
          Uri.parse('$baseurl$saveposturl/$postId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      return null;
    }
  }

//-------------remove saved post-----------------
  static Future<http.Response?> removeSavedPost(
      {required String postId}) async {
    try {
      final token = await getUsertoken();
      http.Response response = await http.delete(
          Uri.parse('$baseurl$unsaveposturl/$postId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      return null;
    }
  }

//---------------get saved posts------------------
  static Future<http.Response?> fetchSavedPosts() async {
    try {
      final token = await getUsertoken();
      http.Response response = await http.get(
          Uri.parse('$baseurl$savedposturl'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      return null;
    }
  }
}
