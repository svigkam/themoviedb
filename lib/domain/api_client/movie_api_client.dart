import 'package:themoviedb/configuration/config.dart';
import 'package:themoviedb/domain/api_client/network_client.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/domain/entity/movie_details_credits.dart';
import 'package:themoviedb/domain/entity/movie_details_video.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';

class MovieApiClient {
  final _networkClient = NetworkClient();

  Future<PopularMovieResponse> popularMovie(int page, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/movie/popular',
      parser,
      {
        'api_key': Configuration.apiKey,
        'page': page.toString(),
        'language': locale,
      },
    );
    return result;
  }

  Future<PopularMovieResponse> searchMovie(
      int page, String locale, String query) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/search/movie',
      parser,
      {
        'api_key': Configuration.apiKey,
        'page': page.toString(),
        'language': locale,
        'query': query,
        'include_adult': true.toString(),
      },
    );
    return result;
  }

  Future<MovieDetails> movieDetails(int movieId, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetails.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/movie/$movieId',
      parser,
      {
        'api_key': Configuration.apiKey,
        'language': locale,
      },
    );
    return result;
  }

  Future<MovieDetailsCredits> getCastForMovieDetails(
      int movieId, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetailsCredits.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/movie/$movieId/credits',
      parser,
      {
        'api_key': Configuration.apiKey,
        'language': locale,
      },
    );
    return result;
  }

  Future<MovieDetailsVideo> getVideosForMovieDetails(
      int movieId, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetailsVideo.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/movie/$movieId/videos',
      parser,
      {
        'api_key': Configuration.apiKey,
        'language': locale,
      },
    );
    return result;
  }

  Future<bool> isFavorite(int movieId, String sessionId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['favorite'] as bool;
      return result;
    }
    final result = _networkClient.get(
      '/movie/$movieId/account_states',
      parser,
      {
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }

 
}