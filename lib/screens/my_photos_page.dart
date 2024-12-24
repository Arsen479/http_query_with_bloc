import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_query_users/album_bloc/user_albums_bloc.dart';
import 'package:flutter_http_query_users/widgets/userAlbumPhotos.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPhotosPage extends StatefulWidget {
  final String albumsId;
  const MyPhotosPage({super.key, required this.albumsId});
  @override
  State<MyPhotosPage> createState() => _MyPhotosPageState();
}

class _MyPhotosPageState extends State<MyPhotosPage> {
  late final UserAlbumsBloc userPhotosBloc;

  @override
  void initState() {
    userPhotosBloc = UserAlbumsBloc();
    userPhotosBloc.add(GetUserAlbumsPhotosEvent(photosId: widget.albumsId));
    super.initState();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPhotosPage'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<UserAlbumsBloc, UserAlbumsState>(
              bloc: userPhotosBloc,
              builder: (context, state) {
                if (state is PhotosLoadedState) {
                  return PhotosContainer(userPhotosBloc: userPhotosBloc, state: state,);
                } else if (state is AlbumsLoadingState) {
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

