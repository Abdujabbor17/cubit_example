import 'package:bloc_example/bloc/post_cubit.dart';
import 'package:bloc_example/bloc/post_state.dart';
import 'package:bloc_example/view/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TextEditingController userIdCtr = TextEditingController();
  // TextEditingController titleCtr = TextEditingController();
  // TextEditingController bodyCtr = TextEditingController();

  List<PostModel> posts = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostCubit>(context).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text(
            "Posts",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state is PostError) {
              return Center(
                child: Text(state.error.toString()),
              );
            }

            if (state is PostLoading) {
              return viewHome(posts, true);
            }

            if (state is PostLoaded) {
              posts = state.posts!;

              return viewHome(posts, false);
            }
            return const Center(child: Text('Unknown error'));
          },
        ));
  }

  Widget viewHome(List<PostModel> posts, bool isLoading) {
    return Stack(
      children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (ctx, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10),
                    child: postItem(context, posts[i], () {
                      // userIdCtr.text = posts[i].userId.toString();
                      // titleCtr.text = posts[i].title;
                      // bodyCtr.text = posts[i].body;
                      // _showBottomSheet(context, () {});

                      //edit func
                    }),
                  );
                })),
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const SizedBox()
      ],
    );
  }

 /*void _showBottomSheet(BuildContext context, void Function() func) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Add new post',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  TextFormField(
                    controller: userIdCtr,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'UserID'),
                  ),
                  TextFormField(
                    controller: titleCtr,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextFormField(
                    controller: bodyCtr,
                    decoration: const InputDecoration(labelText: 'Body'),
                  ),
                  ElevatedButton(
                    onPressed: func,
                    child: const Text('Add'),
                  ),
                  const SizedBox(
                    height: 400,
                  )
                ],
              ),
            ),
          );
        });
  }*/
}
