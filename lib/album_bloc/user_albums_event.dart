part of 'user_albums_bloc.dart';

@immutable
sealed class UserAlbumsEvent {}

final class GetUserAlbumsEvent extends UserAlbumsEvent {
  final String albumsId;

  GetUserAlbumsEvent({required this.albumsId});
}

final class GetUserAlbumsPhotosEvent extends UserAlbumsEvent {
  final String photosId;

  GetUserAlbumsPhotosEvent({required this.photosId});
}
