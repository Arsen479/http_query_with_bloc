import 'package:flutter/material.dart';
import 'package:flutter_http_query_users/album_bloc/user_albums_bloc.dart';

class PhotosContainer extends StatelessWidget {
  final UserAlbumsBloc userPhotosBloc;
  final PhotosLoadedState state;
  const PhotosContainer({
    super.key, required this.userPhotosBloc, required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.5 / 2.3,
      ),
      itemCount: state.photos.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${state.photos[index].title}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Image.network(
                    state.photos[index].url,
                    height: 150,
                    width: 200,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
