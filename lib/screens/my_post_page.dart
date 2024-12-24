import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_query_users/album_bloc/user_albums_bloc.dart';
import 'package:flutter_http_query_users/user_bloc/users_bloc.dart';
import 'package:flutter_http_query_users/models/user_model.dart';
import 'package:flutter_http_query_users/screens/my_albums_page.dart';
import 'package:flutter_http_query_users/widgets/postContainer.dart';
import 'package:flutter_http_query_users/widgets/postsComments.dart';

class MyPostPage extends StatefulWidget {
  final User user;
  const MyPostPage({super.key, required this.user});
  @override
  State<MyPostPage> createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage> {
  late final UsersBloc usersBloc;
  late final UsersBloc commentsBloc;

  @override
  void initState() {
    usersBloc = UsersBloc();
    commentsBloc = UsersBloc();
    usersBloc.add(GetUsersPostsEvent(userid: '${widget.user.id}'));
    //commentsBloc.add(GetUserPostCommentsEvent(postId: '${widget.user.id}'));
    super.initState();
  }

  @override
  void dispose() {
    usersBloc.close();
    commentsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPostPage'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 170,
                width: MediaQuery.of(context).size.width * 0.97,
                decoration: BoxDecoration(
                  border:
                     const Border.fromBorderSide(BorderSide(color: Colors.black12)),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.pink,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${widget.user.name}\nUserName: ${widget.user.username}\nEmail: ${widget.user.email}\nCity: ${widget.user.address.city}\nStreet: ${widget.user.address.street}',
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.pink,
                              overlayColor: Colors.pink,
                              disabledBackgroundColor: Colors.black,
                              fixedSize: Size(100, 30),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyAlbumsPage(
                                    userId: '${widget.user.id}',
                                  ),
                                ),
                              );
                            },
                            child: Text('Albums'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
            thickness: 2,
            height: 10,
          ),
          Expanded(
            //bloc который выводит посты
            child: BlocBuilder<UsersBloc, UsersState>(
              bloc: usersBloc,
              builder: (context, state) {
                if (state is UserPostLoadedState) {
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shrinkWrap: true,
                    itemCount: state.post.length,
                    itemBuilder: (context, index) {
                      return PostContainer(
                        title:
                            '${state.post[index].title}', //выводит posts его title
                        body:
                            '${state.post[index].body}', //выводит posts его body
                        onTap: () {
                          commentsBloc.add(GetUserPostCommentsEvent(
                              postId: '${state.post[index].id}'));
                          showModalBottomSheet(
                            showDragHandle: true,
                            useSafeArea: true,
                            constraints: BoxConstraints(
                              maxHeight: 600,
                              minHeight: 100,
                            ),
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              //bloc который выводит комментарии
                              return Column(
                                children: [
                                  const Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      'Comments',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: BlocBuilder<UsersBloc, UsersState>(
                                      bloc: commentsBloc,
                                      builder: (context, state) {
                                        if (state is CommentsPostLoadedState) {
                                          return PostsComments(
                                            state: state,
                                            commentsBloc: commentsBloc,
                                          );
                                        } else if (state is LoadingState) {
                                          return const Center(
                                            child: CupertinoActivityIndicator(),
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                        thickness: 2,
                        height: 20,
                        indent: 20,
                        endIndent: 20,
                      );
                    },
                  );
                } else if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
