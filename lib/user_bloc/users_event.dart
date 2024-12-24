part of 'users_bloc.dart';

@immutable
sealed class UsersEvent {}

class GetUsersPostsEvent extends UsersEvent {
  final String userid;

  GetUsersPostsEvent({required this.userid});
}

class GetUserEvent extends UsersEvent {
  final String userid;

  GetUserEvent({required this.userid});
}

class GetUsersEvent extends UsersEvent {}

class GetUserPostsEvent extends UsersEvent {}

class GetUserPostCommentsEvent extends UsersEvent {
  final String postId;

  GetUserPostCommentsEvent({required this.postId});
}
