part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

class FetchAllPosts extends PostsEvent {
  @override
  List<Object?> get props => [];
}

class CreateAPosts extends PostsEvent {
  final PostsResponse postModel;
  const CreateAPosts(this.postModel);
  @override
  List<Object?> get props => [];
}

class UpdateAPosts extends PostsEvent {
  final PostsResponse postModel;
  const UpdateAPosts(this.postModel);
  @override
  List<Object?> get props => [];
}

class DeleteAPosts extends PostsEvent {
  final int postId;
  const DeleteAPosts(this.postId);
  @override
  List<Object?> get props => [postId];
}
