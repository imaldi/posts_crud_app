part of 'posts_cubit.dart';

class PostsCubitState {
  List<PostsResponse>? postList;
  PostsCubitState({this.postList});
  @override
  List<Object?> get props => [postList];
}
