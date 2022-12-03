import 'package:dartz/dartz.dart';
import 'package:posts_crud_app/core/platform/network_info.dart';
import 'package:posts_crud_app/data/data_source/remote_data_source/posts_remote_data_source.dart';
import 'package:posts_crud_app/data/models/posts_response.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';

class PostsRepository {
  final NetworkInfo networkInfo;
  final PostsRemoteDataSource postsRemoteDataSource;

  const PostsRepository(
      {required this.networkInfo, required this.postsRemoteDataSource});

  Future<Either<Failure, List<PostsResponse>>> fetchAllPost() async {
    if (!(await networkInfo.isConnected)) return Left(NoInternetFailure());

    try {
      final response = await postsRemoteDataSource.fetchAllPost();

      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, PostsResponse>> createAPost(
      PostsResponse postModel) async {
    if (!(await networkInfo.isConnected)) return Left(NoInternetFailure());

    try {
      final response = await postsRemoteDataSource.createAPost(postModel);

      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, PostsResponse>> updateAPost(
      PostsResponse postModel) async {
    if (!(await networkInfo.isConnected)) return Left(NoInternetFailure());

    try {
      final response = await postsRemoteDataSource.updateAPost(postModel);

      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, bool>> deleteAPost(int postId) async {
    if (!(await networkInfo.isConnected)) return Left(NoInternetFailure());

    try {
      return Right(await postsRemoteDataSource.deleteAPost(postId));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
