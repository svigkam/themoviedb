// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/domain/entity/movie_details_credits.dart';
import 'package:themoviedb/domain/entity/movie_details_video.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';

enum ApiClientExceptionType { Network, Auth, Other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;
  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '0a2a46b5593a0978cc8e87ba34037430';

  static String imageUrl(String path) => _imageUrl + path;

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validToken = await _validateUser(
      username: username,
      password: password,
      requesToken: token,
    );
    final sessionId = await _makeSession(requesToken: validToken);
    return sessionId;
  }

  Future<T> _get<T>(String path, T Function(dynamic json) parser,
      [Map<String, dynamic>? parameters]) async {
    final url = _makeUri(path, parameters);
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = await _jsonParse(response);
      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<T> _post<T>(
    String path,
    T Function(dynamic json) parser,
    Map<String, dynamic>? bodyParameters, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = _makeUri(path, urlParameters);
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final dynamic json = await _jsonParse(response);
      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<String> _makeToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _get(
      '/authentication/token/new',
      parser,
      {'api_key': _apiKey},
    );
    return result;
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requesToken,
  }) async {
    final parametrs = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requesToken,
    };
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _post(
      '/authentication/token/validate_with_login',
      parser,
      parametrs,
      {'api_key': _apiKey},
    );
    return result;
  }

  Future<String> _makeSession({required String requesToken}) async {
    final parametrs = <String, dynamic>{'request_token': requesToken};
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap["session_id"] as String;
      return sessionId;
    }

    final result = _post(
      '/authentication/session/new',
      parser,
      parametrs,
      {'api_key': _apiKey},
    );
    return result;
  }

  Future<PopularMovieResponse> popularMovie(int page, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/movie/popular',
      parser,
      {
        'api_key': _apiKey,
        'page': page.toString(),
        'language': locale,
      },
    );
    return result;
  }

  Future<PopularMovieResponse> searchMovie(int page, String locale, String query) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/search/movie',
      parser,
      {
        'api_key': _apiKey,
        'page': page.toString(),
        'language': locale,
        'query':query,
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

    final result = _get(
      '/movie/$movieId',
      parser,
      {
        'api_key': _apiKey,
        'language': locale,
      },
    );
    return result;
  }

  Future<MovieDetailsCredits> getCastForMovieDetails(int movieId, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetailsCredits.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/movie/$movieId/credits',
      parser,
      {
        'api_key': _apiKey,
        'language': locale,
      },
    );
    return result;
  }

Future<MovieDetailsVideo> getVideosForMovieDetails(int movieId, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetailsVideo.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/movie/$movieId/videos',
      parser,
      {
        'api_key': _apiKey,
        'language': locale,
      },
    );
    return result;
  }

  Future<dynamic> _jsonParse(HttpClientResponse response) async {
    return await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((val) => jsonDecode(val));
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.Auth);
      } else {
        throw ApiClientException(ApiClientExceptionType.Other);
      }
    }
  }
}
