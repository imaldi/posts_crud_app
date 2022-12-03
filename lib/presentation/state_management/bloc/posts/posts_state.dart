part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

class FetcbPostsSuccess extends PostsState {
  final List<PostsResponse> postList;
  const FetcbPostsSuccess(this.postList);
  @override
  List<Object> get props => [
    postList
  ];
}

class FetchPostsFailed extends PostsState {
  @override
  List<Object> get props => [];
}

class LoadingPosts extends PostsState {
  @override
  List<Object> get props => [];
}
