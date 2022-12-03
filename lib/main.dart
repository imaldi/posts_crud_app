import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_crud_app/core/platform/network_info.dart';
import 'package:posts_crud_app/data/data_source/remote_data_source/posts_remote_data_source.dart';
import 'package:posts_crud_app/data/repositories/posts_repository.dart';
import 'package:posts_crud_app/presentation/screens/post_list_screen.dart';
import 'package:posts_crud_app/presentation/state_management/bloc/posts/posts_bloc.dart';
import 'package:posts_crud_app/presentation/state_management/cubit/posts_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create:(context) => PostsBloc(repository: PostsRepository(
          networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
          postsRemoteDataSource: PostsRemoteDataSource(),))),
        BlocProvider(create: (context)=> PostsCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Post List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PostListScreen(title: 'Post List Screen'),
      ),
    );
  }
}

