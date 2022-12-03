import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_crud_app/presentation/state_management/cubit/posts_cubit.dart';
import 'package:posts_crud_app/presentation/widgets/my_toast.dart';

import '../state_management/bloc/posts/posts_bloc.dart';
import 'create_or_update_post_screen.dart';

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
      body: BlocConsumer<PostsBloc, PostsState>(
        listener: (context, state) {
          if (state is FetchPostsSuccess) {
            context.read<PostsCubit>().updateListCache(state.postList);
          }
          if (state is CreatePostsSuccess){
            context.read<PostsCubit>().addListElement(state.postsResponse);
          }
          if(state is UpdatePostsSuccess){
            context.read<PostsCubit>().updateListElementBasedOnId(state.postsResponse);
          }
          if (state is DeletePostsSuccess) {
            context.read<PostsCubit>().removeListElementWhereId(state.postId);
            myToast("Success Delete a Post");
          }
        },
        builder: (context, state) {
          var postList = context.watch<PostsCubit>().state.postList ?? [];

          if (state is FetchPostsSuccess ||
              state is CreatePostsSuccess ||
              state is UpdatePostsSuccess ||
              state is DeletePostsSuccess) {
            return ListView.builder(
                itemCount: postList.length,
                itemBuilder: (c, i) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => CreateOrUpdatePostScreen(
                                postsResponse: postList[i],
                              )));
                    },
                    child: Card(
                        child: ListTile(
                      title: Text(postList[i].title ?? "-"),
                      subtitle: Text(
                        postList[i].body ?? "-",
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: InkWell(
                          onTap: () {
                            context
                                .read<PostsBloc>()
                                .add(DeleteAPosts(postList[i].id ?? 1));
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.blue,
                          )),
                    )),
                  );
                });
          }
          if (state is LoadingPosts) {
            return Container(
                child: const Center(
              child: CircularProgressIndicator(),
            ));
          }
          return Container(
            padding: const EdgeInsets.only(top: 32),
            child: Center(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<PostsBloc>().add(FetchAllPosts());
                },
                child: ListView(
                  children: [
                    Container(
                      child: const Center(
                        child: Text("Failed Fetching, swipe down to refresh"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (c) => const CreateOrUpdatePostScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
