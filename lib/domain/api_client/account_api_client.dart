import 'package:themoviedb/configuration/config.dart';
import 'package:themoviedb/domain/api_client/network_client.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';

enum ApiClientMediaType { movie, tv }

extension ApiClientMediaTypeAsString on ApiClientMediaType {
  String asString() {
    switch (this) {
      case ApiClientMediaType.movie:
        return 'movie';
      case ApiClientMediaType.tv:
        return 'tv';
    }
  }
}

class AccountApiClient {
  final _networkClient = NetworkClient();

  Future<int> getAccountInfo(String sessionId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as int;
      return result;
    }

    final result = _networkClient.get(
      '/account',
      parser,
      {
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }

  Future<PopularMovieResponse> getFavoriteMovies({
    required String sessionId,
    required String accountId,
    required String language,
  }) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.get(
      '/account/${accountId.toString()}/favorite/movies',
      parser,
      {
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
        'language': language
      },
    );
    return result;
  }

  Future<int> markIsFavorite({
    required int accountId,
    required String sessionId,
    required ApiClientMediaType mediaType,
    required int mediaId,
    required bool favorite,
  }) async {
    parser(dynamic json) {
      return 1;
    }

    final parametrs = <String, dynamic>{
      'media_type': mediaType.asString(),
      'media_id': mediaId,
      'favorite': favorite,
    };
    final result = _networkClient.post(
      '/account/$accountId.toString()/favorite',
      parser,
      parametrs,
      {
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }
}
