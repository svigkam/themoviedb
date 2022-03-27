import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/domain/entity/movie_details_credits.dart';
import 'package:themoviedb/domain/entity/movie_details_video.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();

  MovieDetails? _movieDetails;
  MovieDetailsCredits? _movieDetailsCast;
  MovieDetailsVideo? _movieDetailsVideo;

  final int movieId;
  late DateFormat _dateFormat;
  bool _isFavorite = false;
  late final String _locale = 'ru-RU';
  Future<void>? Function()? onSessionExpired;

  MovieDetails? get movieDetails => _movieDetails;
  MovieDetailsCredits? get movieDetailsCast => _movieDetailsCast;
  MovieDetailsVideo? get movieDetailsVideo => _movieDetailsVideo;
  bool? get isFavorite => _isFavorite;

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
    try {
      _movieDetails = await _apiClient.movieDetails(movieId, _locale);
      _movieDetailsCast =
          await _apiClient.getCastForMovieDetails(movieId, _locale);
      _movieDetailsVideo =
          await _apiClient.getVideosForMovieDetails(movieId, _locale);
      final sessionId = await _sessionDataProvider.getSessionId();
      if (sessionId != null) {
        _isFavorite = await _apiClient.isFavorite(movieId, sessionId);
      }
      notifyListeners();
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  Future<void> toggleFavorite(BuildContext context) async {
    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();

    if (sessionId == null || accountId == null) return;

    final newFavoriteValue = !_isFavorite;
    _isFavorite = newFavoriteValue;
    notifyListeners();
    try {
      await _apiClient.markIsFavorite(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: ApiClientMediaType.Movie,
        mediaId: movieId,
        favorite: newFavoriteValue,
      );
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  void _handleApiClientException(ApiClientException exception) {
    switch (exception.type) {
      case ApiClientExceptionType.SessionExpired:
        onSessionExpired?.call();
        break;
      default:
        print(exception);
    }
  }
}
