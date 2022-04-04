import 'package:themoviedb/configuration/config.dart';
import 'package:themoviedb/domain/api_client/movie_api_client.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';

class MovieService {
  final _movieApiClient = MovieApiClient();

  Future<PopularMovieResponse> popularMovie(int page, String locale) async =>
      _movieApiClient.popularMovies(page, locale, Configuration.apiKey);

  Future<PopularMovieResponse> latestMovies(String locale) async =>
      _movieApiClient.latestMovies(locale, Configuration.apiKey);

  Future<PopularMovieResponse> playingMovies(String locale) async =>
      _movieApiClient.nowPlayingMovies(locale, Configuration.apiKey);

  Future<PopularMovieResponse> searchMovie(
          int page, String locale, String query) async =>
      _movieApiClient.searchMovie(page, locale, query, Configuration.apiKey);
}
