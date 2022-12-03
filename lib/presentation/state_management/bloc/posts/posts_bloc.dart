import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:posts_crud_app/core/const/urls.dart';

import '../../../../data/models/posts_response.dart';
import '../../../../data/repositories/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsRepository repository;
  PostsBloc({required this.repository}) : super(PostsInitial()) {
    on<FetchAllPosts>((event, emit) async {
      var failureOrResponseList = await repository.fetchAllPost();
      var newState = failureOrResponseList.fold((l) => FetchPostsFailed(), (r) => FetcbPostsSuccess(r));
      emit(newState);
    });
  }
}
