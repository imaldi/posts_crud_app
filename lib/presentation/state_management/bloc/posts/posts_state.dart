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
  final String? errorMessage;
  const FetchPostsFailed({this.errorMessage});
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
  final String? errorMessage;
  const CreatePostsFailed({this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class UpdatePostsSuccess extends PostsState {
  final PostsResponse postsResponse;
  const UpdatePostsSuccess(this.postsResponse);

  @override
  List<Object?> get props => [postsResponse];
}

class UpdatePostsFailed extends PostsState {
  final String? errorMessage;
  const UpdatePostsFailed({this.errorMessage});
  @override
  List<Object?> get props => [];
}

class DeletePostsSuccess extends PostsState {
  final int postId;
  const DeletePostsSuccess(this.postId);
  @override
  List<Object?> get props => [postId];
}

class DeletePostsFailed extends PostsState {
  final String? errorMessage;
  const DeletePostsFailed({this.errorMessage});
  @override
  List<Object?> get props => [];
}


class LoadingPosts extends PostsState {
  @override
  List<Object> get props => [];
}
