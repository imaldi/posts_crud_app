import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state_management/bloc/posts/posts_bloc.dart';
import 'new_post_screen.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
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
        title: Text(widget.title),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if(state is FetchPostsSuccess){
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
            return Container(child: const Center(child: CircularProgressIndicator(),));
          }
          return Container(
            child: const Center(
              child: Text(
                  "Failed Fetching"
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (c)=>const CreateOrUpdatePostScreen()));
      },
      child: const Icon(Icons.add),
      ),
    );
  }
}
