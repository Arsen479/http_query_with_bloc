part of 'user_albums_bloc.dart';

@immutable
sealed class UserAlbumsState {}

final class UserAlbumsInitial extends UserAlbumsState {}

final class AlbumsLoadingState extends UserAlbumsState {
  
}

final class AlbumsLoadedState extends UserAlbumsState {
  final List<Albums> albums;

  AlbumsLoadedState({required this.albums});
}

final class PhotosLoadedState extends UserAlbumsState {
  final List<Photos> photos;

  PhotosLoadedState({required this.photos});
}

final class ErrorState extends UserAlbumsState {
  final String message;

  ErrorState({required this.message});
}
