import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_crud_app/data/models/posts_response.dart';
import 'package:posts_crud_app/presentation/state_management/bloc/posts/posts_bloc.dart';
import 'package:posts_crud_app/presentation/widgets/my_toast.dart';

class CreateOrUpdatePostScreen extends StatefulWidget {
  final PostsResponse? postsResponse;
  const CreateOrUpdatePostScreen({this.postsResponse, Key? key}) : super(key: key);

  @override
  State<CreateOrUpdatePostScreen> createState() => _CreateOrUpdatePostScreenState();
}

class _CreateOrUpdatePostScreenState extends State<CreateOrUpdatePostScreen> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  var isCreateNew = true;
  @override
  void initState() {
    super.initState();
    isCreateNew = widget.postsResponse == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${isCreateNew ? "Create New Post" : "Update a Post"}"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: formKey,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("New Post Screen"),
                      TextFormField(
                          controller: titleController,
                          validator: (val) {
                            if ((val ?? "").isEmpty) {
                              return "Field ini tidak boleh kosong";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(label: Text("Title"))),
                      TextFormField(
                        controller: bodyController,
                        validator: (val) {
                          if ((val ?? "").isEmpty) {
                            return "Field ini tidak boleh kosong";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(label: Text("Body")),
                        minLines: 5,
                        maxLines: 5,
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: BlocListener<PostsBloc, PostsState>(
                            listener: (context, state) {
                              if(state is CreatePostsSuccess){
                                myToast("Success Creating Post");
                                Navigator.of(context).pop();
                                context.read<PostsBloc>().add(FetchAllPosts());
                              }
                              if(state is CreatePostsFailed){
                                myToast("Failed Creating Post");
                              }
                            },
                            child: ElevatedButton(
                                onPressed: () {
                                  if ((formKey.currentState?.validate() ?? false)) {
                                    formKey.currentState?.save();
                                    context.read<PostsBloc>().add(CreateAPosts(
                                        PostsResponse(
                                            userId: 1,
                                            title: titleController.text,
                                            body: bodyController.text)));
                                  }
                                },
                                child: Text("Create Post")),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
