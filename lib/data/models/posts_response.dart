// To parse this JSON data, do
//
//     final postsResponse = postsResponseFromJson(jsonString);
import 'dart:convert';

import 'package:equatable/equatable.dart';

List<PostsResponse> postsResponseFromJson(String str) => List<PostsResponse>.from(json.decode(str).map((x) => PostsResponse.fromJson(x)));

String postsResponseToJson(List<PostsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostsResponse extends Equatable {
  PostsResponse({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  int? userId;
  int? id;
  String? title;
  String? body;

  factory PostsResponse.fromJson(Map<String, dynamic> json) => PostsResponse(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };

  PostsResponse copyWith(
  int? userId,
  int? id,
  String? title,
  String? body,
  ){
    return PostsResponse(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
    );
  }

  @override
  List<Object?> get props => [
    userId,
    id,
    title,
    body,
  ];
}
