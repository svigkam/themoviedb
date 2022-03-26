import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/domain/entity/movie_details_credits.dart';
import 'package:themoviedb/domain/entity/movie_details_video.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  MovieDetails? _movieDetails;
  MovieDetailsCredits? _movieDetailsCast;
  MovieDetailsVideo? _movieDetailsVideo;

  final int movieId;
  late DateFormat _dateFormat;
  late final String _locale = 'ru-RU';

  MovieDetails? get movieDetails => _movieDetails;
  MovieDetailsCredits? get movieDetailsCast => _movieDetailsCast;
  MovieDetailsVideo? get movieDetailsVideo => _movieDetailsVideo;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  MovieDetailsModel(this.movieId);

  Future<void> setupLocale(BuildContext context) async {
    // final locale = Localizations.localeOf(context).toLanguageTag();
    // if (_locale == locale) return;
    // _locale = locale;
    _dateFormat = DateFormat.yMMMMd(_locale);
    await loadDetails();
  }

  Future<void> loadDetails() async {
    _movieDetails = await _apiClient.movieDetails(movieId, _locale);
    _movieDetailsCast = await _apiClient.getCastForMovieDetails(movieId, _locale);
    _movieDetailsVideo = await _apiClient.getVideosForMovieDetails(movieId, _locale);
    notifyListeners();
  }
}
