import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../elements/circle_progress_bar.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _TopPostersWidget(),
        _MovieNameWidget(),
        _ScoreAndTrailerWidget(),
        _SummaryWidget(),
        _OverViewWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _PeopleWidget(),
        ),
        SizedBox(height: 25),
      ],
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: AppText(text: 'Описание', size: 18, color: whiteColor),
        ),
        ColoredBox(
          color: const Color.fromRGBO(22, 21, 25, 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: AppText(color: whiteColor, size: 16, text: overview),
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}

class _TopPostersWidget extends StatelessWidget {
  const _TopPostersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieDetailsModel>();
    final posterData =
        context.select((MovieDetailsModel model) => model.data.posterData);
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          if (posterData.backdropPath != null)
            Image.network(ImageDownloader.imageUrl(posterData.backdropPath!)),
          if (posterData.posterPath != null)
            Positioned(
              top: 20,
              bottom: 20,
              left: 20,
              child: Image.network(
                ImageDownloader.imageUrl(posterData.posterPath!),
              ),
            ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color: model.isFavorite == true
                    ? Colors.red
                    : Colors.white.withOpacity(.5),
                size: 30,
              ),
              onPressed: () => model.toggleFavorite(context),
            ),
          )
        ],
      ),
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameData =
        context.select((MovieDetailsModel model) => model.data.nameData);
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RichText(
          maxLines: 3,
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: nameData.title,
                style: const TextStyle(
                  color: whiteColor,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: nameData.year,
                style: const TextStyle(
                  color: whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreAndTrailerWidget extends StatelessWidget {
  const _ScoreAndTrailerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scoreData =
        context.select((MovieDetailsModel model) => model.data.scoreData);
    final voteAverage = scoreData.voteAvarage * 10;
    final trailerKey = scoreData.trailerKey;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {},
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: RadialPercentWidget(
                      child: Text(voteAverage.toStringAsFixed(0)),
                      percent: voteAverage / 100,
                      fillColor: const Color.fromARGB(255, 10, 23, 25),
                      lineColor: const Color.fromARGB(255, 37, 203, 103),
                      freeColor: const Color.fromARGB(255, 25, 54, 31),
                      lineWidth: 3),
                ),
                const SizedBox(width: 10),
                const Text('User Score'),
              ],
            )),
        Container(
          color: Colors.grey,
          width: 1,
          height: 15,
        ),
        trailerKey != null
            ? _TrailerWidget(trailerKey: trailerKey)
            : TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    const Icon(
                      Icons.play_arrow,
                      color: Colors.grey,
                    ),
                    AppText(
                      size: 14,
                      text: 'Play Trailer',
                      color: Colors.grey,
                      lineThrough: true,
                    )
                  ],
                ),
              )
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final summary =
        context.select((MovieDetailsModel model) => model.data.summary);
    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: AppText(
            alignCenter: true,
            maxLines: 3,
            text:summary,
            size: 14,
            color: whiteColor),
      ),
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final crewChunks =
        context.select((MovieDetailsModel model) => model.data.peopleData);
    return Column(
      children: crewChunks
          .map(
            (chunk) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _PeopleWidgetsRow(crew: chunk),
            ),
          )
          .toList(),
    );
  }
}

class _PeopleWidgetsRow extends StatelessWidget {
  final List<MovieDetailsPeopleData> crew;
  const _PeopleWidgetsRow({required this.crew, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: crew.map((e) => _PeopleWidgetsRowItem(crew: e)).toList(),
    );
  }
}

class _PeopleWidgetsRowItem extends StatelessWidget {
  final MovieDetailsPeopleData crew;
  const _PeopleWidgetsRowItem({
    required this.crew,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(text: crew.name, size: 16, color: whiteColor),
          AppText(text: crew.job, size: 16, color: whiteColor.withOpacity(.6)),
        ],
      ),
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
    return TextButton(
      onPressed: () {
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
      child: Row(
        children: const [
          Icon(Icons.play_arrow),
          Text('Play Trailer'),
        ],
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
