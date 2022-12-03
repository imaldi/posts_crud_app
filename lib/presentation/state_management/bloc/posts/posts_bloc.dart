import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:posts_crud_app/core/const/urls.dart';

import '../../../../core/helper/helper_functions.dart';
import '../../../../data/models/posts_response.dart';
import '../../../../data/repositories/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsRepository repository;
  PostsBloc({required this.repository}) : super(PostsInitial()) {
    on<FetchAllPosts>((event, emit) async {
      emit(LoadingPosts());
      var failureOrResponseList = await repository.fetchAllPost();
      var newState = failureOrResponseList.fold((l) => FetchPostsFailed(errorMessage: getErrorBasedOnFailureType(l)), (r) => FetchPostsSuccess(r));
      emit(newState);
    });
    on<CreateAPosts>((event, emit) async {
      emit(LoadingPosts());
      var failureOrResponseList = await repository.createAPost(event.postModel);
      var newState = failureOrResponseList.fold((l) => CreatePostsFailed(errorMessage: getErrorBasedOnFailureType(l)), (r) => CreatePostsSuccess(r));
      emit(newState);
    });
    on<UpdateAPosts>((event, emit) async {
      emit(LoadingPosts());
      var failureOrResponseList = await repository.updateAPost(event.postModel);
      var newState = failureOrResponseList.fold((l) => UpdatePostsFailed(errorMessage: getErrorBasedOnFailureType(l)), (r) => UpdatePostsSuccess(r));
      emit(newState);
    });
    on<DeleteAPosts>((event, emit) async {
      emit(LoadingPosts());
      var failureOrResponseList = await repository.deleteAPost(event.postId);
      var newState = failureOrResponseList.fold((l) => DeletePostsFailed(errorMessage: getErrorBasedOnFailureType(l)), (r) => DeletePostsSuccess(event.postId));
      emit(newState);
    });
  }
}
