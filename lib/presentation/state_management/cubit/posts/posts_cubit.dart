import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import '../../../../data/models/posts_response.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsCubitState> {
  PostsCubit() : super(PostsCubitState());

  updateListCache(List<PostsResponse> listPosts){
    emit(PostsCubitState(postList: listPosts));
  }
  addListElement(PostsResponse postsResponse){
    state.postList?.add(postsResponse);
    emit(PostsCubitState(postList: state.postList));
  }
  updateListElementBasedOnId(PostsResponse postsResponse){
    print("postsResponse $postsResponse");
    var indexx = state.postList?.indexWhere((element) => element.id == postsResponse.id);
    if(indexx != null) {
      state.postList?[indexx] = postsResponse;
      print("state.postList?[indexx] ${state.postList?[indexx]}");
    }
    emit(PostsCubitState(postList: state.postList));
  }
  removeListElementWhereId(int postId){
    state.postList?.removeWhere((element) => element.id == postId);
    emit(PostsCubitState(postList: state.postList));
  }
}
