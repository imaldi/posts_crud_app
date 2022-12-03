import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/posts_response.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsCubitState> {
  PostsCubit() : super(PostsCubitState());

  updateListCache(List<PostsResponse> listPosts){
    emit(PostsCubitState(postList: listPosts));
  }
  removeListElementWhereId(int postId){
    state.postList?.removeWhere((element) => element.id == postId);
    emit(PostsCubitState(postList: state.postList));
  }
}
