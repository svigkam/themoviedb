import 'package:flutter/material.dart';
import 'package:themoviedb/Libarary/Widgets/Inherited/provider.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details_credits.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../elements/circle_progress_bar.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TopPostersWidget(),
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: _MovieNameWidget(),
          ),
        ),
        const _ScoreAndTrailerWidget(),
        const _SummeryWidget(),
        // overview
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: AppText(text: 'Описание', size: 18, color: whiteColor),
        ),
        // overview text
        const _OverViewWidget(),
        const SizedBox(height: 25),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _PeopleWidget(),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}

class _OverViewWidget extends StatelessWidget {
  const _OverViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);

    final overview = model?.movieDetails?.overview ?? '';

    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: AppText(color: whiteColor, size: 16, text: overview),
      ),
    );
  }
}

class _TopPostersWidget extends StatelessWidget {
  const _TopPostersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ApiClient.imageUrl(backdropPath))
              : const SizedBox.shrink(),
          Positioned(
            top: 20,
            bottom: 20,
            left: 20,
            child: posterPath != null
                ? Image.network(ApiClient.imageUrl(posterPath))
                : const SizedBox.shrink(),
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
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var year = model?.movieDetails?.releaseDate?.year.toString();
    year != null ? year = ' ($year)' : '';
    return RichText(
      maxLines: 3,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: model?.movieDetails?.title ?? '',
            style: const TextStyle(
              color: whiteColor,
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: year,
            style: const TextStyle(
              color: whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreAndTrailerWidget extends StatelessWidget {
  const _ScoreAndTrailerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var voteAverage = model?.movieDetails?.voteAverage.toDouble();
    voteAverage != null ? voteAverage = (voteAverage * 10) : voteAverage = 0;

    final videos = model?.movieDetailsVideo?.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;

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
            : const SizedBox.shrink(),
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var texts = <String>[];

    final releaseDate = model?.movieDetails?.releaseDate;
    if (releaseDate != null) {
      texts.add(model!.stringFromDate(releaseDate));
    }

    final productionCountries = model?.movieDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      texts.add('(${productionCountries.first.iso})');
    }

    final runtime = model?.movieDetails?.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    texts.add('${hours}h ${minutes}m');

    var genresNames = [];
    final genres = model?.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      for (var genre in genres) {
        genresNames.add(genre.name);
      }
      genresNames.join(', ');
      texts.add(genresNames.join(', '));
    }

    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: AppText(
            alignCenter: true,
            maxLines: 3,
            text: texts.join(' '),
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
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var crew = model?.movieDetailsCast?.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;
    var crewChunks = <List<Crew>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks.add(
        crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }

    return Column(
        children: crewChunks
            .map((chunk) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _PeopleWidgetsRow(crew: chunk),
                ))
            .toList());
  }
}

class _PeopleWidgetsRow extends StatelessWidget {
  final List<Crew> crew;
  const _PeopleWidgetsRow({
    required this.crew,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: crew.map((e) => _PeopleWidgetsRowItem(crew: e)).toList());
  }
}

class _PeopleWidgetsRowItem extends StatelessWidget {
  final Crew crew;
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
          mute: true,
        ));
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
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      color: Color.fromRGBO(24, 23, 27, 1),
    ),
    // padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
