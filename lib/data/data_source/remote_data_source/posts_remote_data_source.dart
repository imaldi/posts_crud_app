import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:posts_crud_app/data/models/posts_response.dart';

import '../../../core/const/urls.dart';
import '../../../core/error/exceptions.dart';

class PostsRemoteDataSource {

  Future<List<PostsResponse>> fetchAllPost() async {
    final url = Uri.https(baseUrl,postUrl);

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var theResponse = postsResponseFromJson(response.body.toString());
      var isResponseDataNull = theResponse.isEmpty;
      if (isResponseDataNull) {
        throw ServerException();
      }
      return theResponse;
    } else {
      throw ServerException();
    }
  }
  Future<PostsResponse> createAPost(PostsResponse postModel) async {
    final url = Uri.https(baseUrl,postUrl);

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'userId': (postModel.userId ?? 1).toString(),
        'title': postModel.title ?? "default title",
        'body': postModel.body ?? "default body",
      }
    );

    if (response.statusCode == HttpStatus.created) {
      var theResponse = PostsResponse.fromJson(jsonDecode(response.body));
      // var isResponseDataNull = theResponse == null;
      // if (isResponseDataNull) {
      //   throw ServerException();
      // }
      print("theResponse $theResponse");
      return theResponse;
    } else {
      print("theResponse code ${response.statusCode}");
      print("theResponse body ${response.body}");

      throw ServerException();
    }
  }
  Future<PostsResponse> updateAPost(PostsResponse postModel) async {
    final url = Uri.https(baseUrl,"$postUrl/${postModel.id ?? 1}");
    print("url update: $url");

    final response = await http.put(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'id': (postModel.id ?? 1).toString(),
        'userId': (postModel.userId ?? 1).toString(),
        'title': postModel.title ?? "default title",
        'body': postModel.body ?? "default body",
      }
    );

    if (response.statusCode == HttpStatus.ok) {
      var theResponse = PostsResponse.fromJson(jsonDecode(response.body));
      // var isResponseDataNull = theResponse == null;
      // if (isResponseDataNull) {
      //   throw ServerException();
      // }
      print("theResponse $theResponse");
      return theResponse;
    } else {
      print("theResponse code ${response.statusCode}");
      print("theResponse body ${response.body}");

      throw ServerException();
    }
  }
}