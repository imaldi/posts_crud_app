import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_crud_app/core/platform/network_info.dart';
import 'package:posts_crud_app/data/data_source/remote_data_source/posts_remote_data_source.dart';
import 'package:posts_crud_app/data/repositories/posts_repository.dart';
import 'package:posts_crud_app/presentation/state_management/bloc/posts/posts_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostsBloc(repository: PostsRepository(
            networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
            postsRemoteDataSource: PostsRemoteDataSource(),)),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var text = 'You have pushed the button this many times:';

  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(FetchAllPosts());
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if(state is FetcbPostsSuccess){
            return ListView.builder(
                itemCount: state.postList.length,
                itemBuilder: (c,i){
              return
                Card(child: ListTile(
                  title: Text(state.postList[i].title ?? "-"),
                  subtitle: Text(state.postList[i].body ?? "-",softWrap: true,maxLines: 2,overflow: TextOverflow.ellipsis,),
                ));
            });
          }
          if(state is LoadingPosts){
            return const Center(child: CircularProgressIndicator(),);
          }
          return const Center(
            child: Text(
                "Failed Fetching"
            ),
          );
        },
      ),
    );
  }
}
