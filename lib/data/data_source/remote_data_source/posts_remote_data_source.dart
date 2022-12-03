import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:posts_crud_app/data/models/posts_response.dart';

import '../../../core/const/urls.dart';
import '../../../core/error/exceptions.dart';

class PostsRemoteDataSource {

  Future<List<PostsResponse>> fetchAllPost() async {
    final url = Uri.https(baseUrl,fetchAll);

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
}