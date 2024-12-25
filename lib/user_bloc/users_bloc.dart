import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_http_query_users/models/user_post_comments_model.dart';
import 'package:flutter_http_query_users/models/user_model.dart';
import 'package:flutter_http_query_users/models/user_posts_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<GetUserEvent>(
      (event, emit) async {
        emit(LoadingState());

        //String mainUrl =
        //'https://jsonplaceholder.typicode.com/users?id=${event.userid}';
        String mainUrl = 'https://jsonplaceholder.typicode.com/users';
        final uri = Uri.parse(mainUrl);

        try {
          final response = await http.get(uri);
          final data = jsonDecode(response.body);

          final user = data.firstWhere(
            (element) => element['name'] == event.userid,
            orElse: () => null,
          );

          if (user != null) {
            User foundUser = User.fromJson(user);

            log('User Found: $foundUser');

            emit(UsersLoadedState2(usersy: [foundUser]));
          } else {
            log('User not found');
          }
        } catch (e) {
          log(e.toString());
          emit(ErrorState(message: e.toString()));
        }
      },
    );

    on<GetUsersPostsEvent>(
      (event, emit) async {
        emit(LoadingState());

        String mainUrl =
            'https://jsonplaceholder.typicode.com/posts?userId=${event.userid}';
        final uri = Uri.parse(mainUrl);

        try {
          final response = await http.get(uri);
          final data = jsonDecode(response.body);
          List<Post> users = [];
          for (var i = 0; i < data.length; i++) {
            users.add(Post.fromJson(data[i]));
          }

          log('Response status: $users');
          await Future.delayed(Duration(seconds: 1));

          emit(UserPostLoadedState(post: users));
        } catch (e) {
          log(e.toString());
          emit(ErrorState(message: e.toString()));
        }
      },
    );

    on<GetUsersEvent>(
      (event, emit) async {
        emit(LoadingState());

        String mainUrl = 'https://jsonplaceholder.typicode.com/users';
        final uri = Uri.parse(mainUrl);

        try {
          final response = await http.get(uri);
          final data = jsonDecode(response.body);
          List<User> users = [];
          for (var i = 0; i < data.length; i++) {
            users.add(User.fromJson(data[i]));
          }
          log('Response status: $users');
          await Future.delayed(Duration(seconds: 1));

          emit(UsersLoadedState2(usersy: users));
        } catch (e) {
          log(e.toString());
          emit(ErrorState(message: e.toString()));
        }
      },
    );

    on<GetUserPostCommentsEvent>(
      (event, emit) async {
        emit(LoadingState());

        String mainUrl =
            'https://jsonplaceholder.typicode.com/comments?postId=${event.postId}';
        final uri = Uri.parse(mainUrl);

        try {
          final response = await http.get(uri);
          final data = jsonDecode(response.body);
          List<Comments> comments = [];
          for (var i = 0; i < data.length; i++) {
            comments.add(Comments.fromJson(data[i]));
          }
          log('Response status: $comments');
          emit(CommentsPostLoadedState(comments: comments));
        } catch (e) {
          log(e.toString());
          emit(ErrorState(message: e.toString()));
        }
      },
    );
  }
}
