import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _PosterAndDataWidget(),
        _OverViewWidget(),
        _CastListWidget(),
        _ButtonsRowWidget(),
        SizedBox(height: 30),
      ],
    );
  }
}

class _PosterAndDataWidget extends StatelessWidget {
  const _PosterAndDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        _BackdropPosterWidget(),
        _MovieMainDataWidget(),
      ],
    );
  }
}

class _BackdropPosterWidget extends StatelessWidget {
  const _BackdropPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterData =
        context.select((MovieDetailsModel model) => model.data.posterData);
    final trailerKey = posterData.trailerKey;
    if (posterData.backdropPath != null) {
      return AspectRatio(
        aspectRatio: 390 / 219,
        child: Stack(
          children: [
            Image.network(
              ImageDownloader.imageUrl(
                posterData.backdropPath!,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [background, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            if (trailerKey != null) _TrailerWidget(trailerKey: trailerKey)
          ],
        ),
      );
    } else {
      return const AspectRatio(aspectRatio: 390 / 219);
    }
  }
}

class _MovieMainDataWidget extends StatelessWidget {
  const _MovieMainDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainData =
        context.select((MovieDetailsModel model) => model.data.mainData);
    return Padding(
      padding: const EdgeInsets.only(top: 140, left: 20, right: 20),
      child: SizedBox(
        height: 200,
        child: Row(children: [
          Positioned(
            top: 20,
            bottom: 20,
            left: 20,
            child: Image.network(
              ImageDownloader.imageUrl(mainData.posterPath!),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 180,
                child: AppText(
                  size: 22,
                  text: mainData.title ?? '',
                  isBold: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  AppText(size: 16, text: mainData.year ?? ''),
                  const SizedBox(width: 15),
                  AppText(size: 16, text: mainData.time ?? ''),
                ],
              ),
              const SizedBox(height: 5),
              AppText(
                  size: 16, text: 'Оценили ${mainData.voteCount!.round()} раз'),
              const SizedBox(height: 20),
              Row(
                children: [
                  AppText(size: 19, text: mainData.voteAvarage.toString()),
                  const Icon(Icons.star, color: Colors.amber),
                  const Icon(Icons.star, color: Colors.amber),
                  const Icon(Icons.star, color: Colors.amber),
                  const Icon(Icons.star, color: Colors.amber),
                  const Icon(Icons.star, color: Colors.amber),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}

class _OverViewWidget extends StatelessWidget {
  const _OverViewWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final overview =
        context.select((MovieDetailsModel model) => model.data.overview);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: AppText(color: whiteColor, size: 17, text: overview),
        ),
      ],
    );
  }
}

class _CastListWidget extends StatelessWidget {
  const _CastListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieDetailsModel>();
    var length = model.movieDetailsCast!.cast.length;
    var cast = model.movieDetailsCast?.cast;
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              AppText(size: 22, text: 'Cast & Crew', isBold: FontWeight.w400),
        ),
        SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ListView.builder(
              itemCount: length,
              itemExtent: 120,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return _CastListItemWidget(castIndex: index);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _CastListItemWidget extends StatelessWidget {
  final int castIndex;
  const _CastListItemWidget({required this.castIndex, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieDetailsModel>();
    var actor = model.movieDetailsCast!.cast[castIndex];
    final profilePath = actor.profilePath;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            boxShadow: [
              BoxShadow(
                color: const Color(0xffac55ff).withOpacity(.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: secondaryText,
            backgroundImage: profilePath != null
                ? NetworkImage(ImageDownloader.imageUrl(profilePath))
                : null,
          ),
        ),
        AppText(
          size: 16,
          text: actor.name,
          isBold: FontWeight.bold,
          alignCenter: true,
        ),
        AppText(
            size: 15,
            text: actor.character,
            color: secondaryText,
            alignCenter: true),
      ],
    );
  }
}

class _ButtonsRowWidget extends StatelessWidget {
  const _ButtonsRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieDetailsModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const CircleAvatar(
              backgroundColor: bottomNavColor,
              child: Icon(Icons.thumb_up, color: primaryText),
              radius: 30,
            ),
            const SizedBox(height: 7),
            AppText(size: 18, text: 'Нравится')
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () => model.toggleFavorite(context),
              child: CircleAvatar(
                backgroundColor: model.isFavorite != true
                    ? bottomNavColor
                    : const Color(0xffac55ff),
                child: const Icon(Icons.favorite, color: primaryText),
                radius: 30,
              ),
            ),
            const SizedBox(height: 7),
            AppText(size: 18, text: 'Закладки')
          ],
        ),
        Column(
          children: [
            const CircleAvatar(
              backgroundColor: bottomNavColor,
              child: Icon(Icons.comment, color: primaryText),
              radius: 30,
            ),
            const SizedBox(height: 7),
            AppText(size: 18, text: 'Отзывы')
          ],
        ),
      ],
    );
  }
}

class _TrailerWidget extends StatefulWidget {
  final String trailerKey;
  const _TrailerWidget({Key? key, required this.trailerKey}) : super(key: key);
  @override
  State<_TrailerWidget> createState() => __TrailerWidgetState();
}

class __TrailerWidgetState extends State<_TrailerWidget> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.trailerKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            builder: (BuildContext context) {
              return _showTrailerBottomSheet(
                widget.trailerKey,
                _controller,
              );
            },
          );
        },
        child: const CircleAvatar(
          child: Icon(
            Icons.play_arrow_rounded,
            color: primaryText,
            size: 32,
          ),
          backgroundColor: purple,
          radius: 24,
        ),
      ),
    );
  }
}

Widget _showTrailerBottomSheet(
    String trailerKey, YoutubePlayerController controller) {
  return Container(
    decoration: const BoxDecoration(
      color: Color.fromRGBO(24, 23, 27, 1),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    child: YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return player;
      },
    ),
  );
}
