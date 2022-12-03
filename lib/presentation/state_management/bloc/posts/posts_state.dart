part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

class FetchPostsSuccess extends PostsState {
  final List<PostsResponse> postList;
  const FetchPostsSuccess(this.postList);
  @override
  List<Object> get props => [
    postList
  ];
}

class FetchPostsFailed extends PostsState {
  @override
  List<Object> get props => [];
}

class CreatePostsSuccess extends PostsState {
  final PostsResponse postsResponse;
  const CreatePostsSuccess(this.postsResponse);

  @override
  List<Object?> get props => [postsResponse];
}

class CreatePostsFailed extends PostsState {
  @override
  List<Object?> get props => [];
}

class LoadingPosts extends PostsState {
  @override
  List<Object> get props => [];
}
