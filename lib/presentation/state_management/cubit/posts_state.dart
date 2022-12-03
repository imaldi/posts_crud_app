part of 'posts_cubit.dart';

class PostsCubitState extends Equatable{
  final List<PostsResponse>? postList;
  const PostsCubitState({this.postList});
  @override
  List<Object?> get props => [postList];
}
