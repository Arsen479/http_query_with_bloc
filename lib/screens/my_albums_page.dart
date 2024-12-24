import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_query_users/album_bloc/user_albums_bloc.dart';
import 'package:flutter_http_query_users/screens/my_photos_page.dart';

class MyAlbumsPage extends StatefulWidget {
  final String userId;
  const MyAlbumsPage({super.key, required this.userId});
  @override
  State<MyAlbumsPage> createState() => _MyAlbumsPageState();
}

class _MyAlbumsPageState extends State<MyAlbumsPage> {
  late final UserAlbumsBloc userAlbumsBloc;

  @override
  void initState() {
    userAlbumsBloc = UserAlbumsBloc();
    userAlbumsBloc.add(GetUserAlbumsEvent(albumsId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyAlbumsPage'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<UserAlbumsBloc, UserAlbumsState>(
              bloc: userAlbumsBloc,
              builder: (context, state) {
                if (state is AlbumsLoadedState) {
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.albums.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MyPhotosPage(
                                albumsId: '${state.albums[index].id}',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          //height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.albums[index].title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Colors.black,
                      );
                    },
                  );
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
