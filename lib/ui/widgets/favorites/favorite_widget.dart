import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/widgets/favorites/favorite_model.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<FavoriteModel>();
    return LiquidPullToRefresh(
      showChildOpacityTransition: false,
      onRefresh: () => model.getMovies(),
      child: const _MovieListWidget(),
    );
  }
}

class _MovieListWidget extends StatelessWidget {
  const _MovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FavoriteModel>();
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: model.favoriteMovies.length,
      itemExtent: 163,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return _MovieListRowWidget(index: index);
      },
    );
  }
}

class _MovieListRowWidget extends StatelessWidget {
  final int index;
  const _MovieListRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<FavoriteModel>();
    final movie = model.favoriteMovies[index];
    final posterPath = movie.posterPath;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: black.withOpacity(.2)),
              borderRadius: BorderRadius.circular(10),
              color: lightPrimary,
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                if (posterPath != null)
                  Image.network(ImageDownloader.imageUrl(posterPath),
                      width: 95),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppText(
                              size: 18,
                              text: movie.title!,
                              isBold: FontWeight.bold,
                              maxLines: 1,
                              overflow: true,
                            ),
                          ),
                          Icon(Icons.favorite, color: Colors.red),
                        ],
                      ),
                      const SizedBox(height: 5),
                      AppText(
                        size: 16,
                        text: movie.releaseDate!,
                        color: secondaryText,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 12),
                      AppText(
                        size: 16,
                        text: movie.overview!,
                        overflow: true,
                        color: primaryText,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => model.onMovieTap(context, index),
            ),
          )
        ],
      ),
    );
  }
}
