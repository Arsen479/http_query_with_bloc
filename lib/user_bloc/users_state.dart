part of 'users_bloc.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class LoadingState extends UsersState {}

final class UserPostLoadedState extends UsersState {
  final List<Post> post;

  UserPostLoadedState({required this.post});
}

final class UsersLoadedState2 extends UsersState {
  final List<User> usersy;

  UsersLoadedState2({required this.usersy});
}

final class CommentsPostLoadedState extends UsersState {
  final List<Comments> comments;

  CommentsPostLoadedState({required this.comments});
}

final class ErrorState extends UsersState {
  final String message;

  ErrorState({required this.message});
}
