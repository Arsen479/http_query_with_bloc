import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_http_query_users/models/user_almums_model.dart';
import 'package:flutter_http_query_users/models/user_photos_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'user_albums_event.dart';
part 'user_albums_state.dart';

class UserAlbumsBloc extends Bloc<UserAlbumsEvent, UserAlbumsState> {
  UserAlbumsBloc() : super(UserAlbumsInitial()) {
    on<GetUserAlbumsEvent>((event, emit) async {

      emit(AlbumsLoadingState());

      String mainUrl =
          'https://jsonplaceholder.typicode.com/albums?userId=${event.albumsId}';
      final uri = Uri.parse(mainUrl);

      try {
        final response = await http.get(uri);
        final data = jsonDecode(response.body);
        List<Albums> albums = [];
        for (var i = 0; i < data.length; i++) {
          albums.add(Albums.fromJson(data[i]));
        }
        log('Response status: $albums');
        await Future.delayed(Duration(seconds: 1));

        emit(AlbumsLoadedState(albums: albums));
      } catch (e) {
        log(e.toString());
        emit(ErrorState(message: e.toString()));
      }
    });

    on<GetUserAlbumsPhotosEvent>((event, emit) async {
      emit(AlbumsLoadingState());

      String mainUrl =
          'https://jsonplaceholder.typicode.com/photos?albumId=${event.photosId}';
      final uri = Uri.parse(mainUrl);

      try {
        final response = await http.get(uri);
        final data = jsonDecode(response.body);
        List<Photos> photos = [];
        for (var i = 0; i < data.length; i++) {
          photos.add(Photos.fromJson(data[i]));
        }
        log('Response status: $photos');
        await Future.delayed(Duration(seconds: 1));
        
        emit(PhotosLoadedState(photos: photos));
      } catch (e) {
        log(e.toString());
        emit(ErrorState(message: e.toString()));
      }
    });
  }
}
