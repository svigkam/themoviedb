import 'dart:convert';
import 'dart:io';

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '0a2a46b5593a0978cc8e87ba34037430';

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

  Future<String> _makeToken() async {
    
    final url = _makeUri('/authentication/token/new', {'api_key': _apiKey});
    final request = await _client.getUrl(url);
    final response = await request.close();

    final json = await response.transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((val) => jsonDecode(val)) as Map<String, dynamic>;
    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requesToken,
  }) async {
    final url = _makeUri(
        '/authentication/token/validate_with_login', {'api_key': _apiKey});
    final parametrs = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requesToken,
    };
    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parametrs));
    final response = await request.close();

     final json = await response.transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((val) => jsonDecode(val)) as Map<String, dynamic>;
    final token = json["request_token"] as String;
    return token;
  }

  Future<String> _makeSession({required String requesToken}) async {
    final url = _makeUri('/authentication/session/new', {'api_key': _apiKey});
    final parametrs = <String, dynamic>{'request_token': requesToken};
    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parametrs));
    final response = await request.close();
    final json =await response.transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((val) => jsonDecode(val)) as Map<String, dynamic>;
    final sessionId = json["session_id"] as String;
    return sessionId;
  }
}
