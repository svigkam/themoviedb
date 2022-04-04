import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/services/movie_service.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MovieListRowData {
  final String? title;
  final String? releaseDate;
  final String? posterPath;
  final String? backdropPath;
  final int? id;
  final double? voteAvarage;
  final String? overview;

  MovieListRowData({
    required this.backdropPath,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.id,
    required this.voteAvarage,
    required this.overview,
  });
}

class NewsModel extends ChangeNotifier {
  final _movieService = MovieService();

  String _locale = '';
  late DateFormat _dateFormat;

  var _playingMovies = <MovieListRowData>[];
  List<MovieListRowData> get playingMovies => _playingMovies;
  var _popularMovies = <MovieListRowData>[];
  List<MovieListRowData> get popularMovies => _popularMovies;
  var _upcomingMovies = <MovieListRowData>[];
  List<MovieListRowData> get upcomingMovies => _upcomingMovies;

  NewsModel() {
    _getMovies();
  }

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(_locale);
  }

  Future<void> _getMovies() async {
    final playingMovies = await _movieService.playingMovies('ru-RU');
    _playingMovies = playingMovies.movies.map(_makeRowData).toList();

    final popularMovies = await _movieService.popularMovie(1, 'ru-RU');
    _popularMovies = popularMovies.movies.map(_makeRowData).toList();

    final upcomingMovies = await _movieService.upcoming('ru-RU');
    _upcomingMovies = upcomingMovies.movies.map(_makeRowData).toList();

    notifyListeners();
  }

  MovieListRowData _makeRowData(Movie movie) {
    final releaseDate = movie.releaseDate;
    final releaseDateTitle =
        releaseDate != null ? _dateFormat.format(releaseDate) : '';
    return MovieListRowData(
      title: movie.title,
      releaseDate: releaseDateTitle,
      posterPath: movie.posterPath,
      id: movie.id,
      voteAvarage: movie.voteAverage,
      backdropPath: movie.backdropPath,
      overview: movie.overview,
    );
  }

  void onMovieTap(BuildContext context, int id) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: id,
    );
  }
}
