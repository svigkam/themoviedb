import 'package:themoviedb/configuration/config.dart';
import 'package:themoviedb/domain/api_client/network_client.dart';

class AuthApiClient {
  final _networkClient = NetworkClient();

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

  Future<String> _makeToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _networkClient.get(
      '/authentication/token/new',
      parser,
      {'api_key': Configuration.apiKey},
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

    final result = _networkClient.post(
      '/authentication/token/validate_with_login',
      parser,
      parametrs,
      {'api_key': Configuration.apiKey},
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

    final result = _networkClient.post(
      '/authentication/session/new',
      parser,
      parametrs,
      {'api_key': Configuration.apiKey},
    );
    return result;
  }
}
