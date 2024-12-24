import 'package:flutter/material.dart';
import 'package:flutter_http_query_users/album_bloc/user_albums_bloc.dart';
import 'package:flutter_http_query_users/user_bloc/users_bloc.dart';

class PostsComments extends StatelessWidget {
  final UsersBloc commentsBloc;
  final CommentsPostLoadedState state;

  const PostsComments({
    super.key,
    required this.state,
    required this.commentsBloc,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: state.comments.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.account_circle,
                size: 35,
                color: Colors.pink,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${state.comments[index].name}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${state.comments[index].email}\n${state.comments[index].body}',
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
        });
  }
}
