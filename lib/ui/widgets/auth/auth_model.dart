import 'package:flutter/material.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextController = TextEditingController(text: 'igkam');
  final passwordTextController = TextEditingController(text: 'svenigor');

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get isAuthProgress => _isAuthProgress;
  bool get canStartAuth => !_isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль';
      showSnackBar(context, _errorMessage!, color: Colors.red);
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    int? accountId;
    try {
      sessionId = await _apiClient.auth(
        username: login,
        password: password,
      );
      accountId = await _apiClient.getAccountInfo(sessionId);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.Network:
          _errorMessage =
              'Сервер не доступен. Проверьте подключение к интернету.';
          showSnackBar(context, _errorMessage!, color: Colors.red);
          break;
        case ApiClientExceptionType.Auth:
          _errorMessage = 'Неверный логин и пароль!';
          showSnackBar(context, _errorMessage!, color: Colors.red);
          break;
        case ApiClientExceptionType.Other:
          _errorMessage = 'Произошла ошибка. Попробуйте еще раз.';
          showSnackBar(context, _errorMessage!, color: Colors.red);
          break;
      }
    }
    _isAuthProgress = false;
    notifyListeners();
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
    if (sessionId != null || accountId == null) {
      Navigator.of(context)
          .pushReplacementNamed(MainNavigationRouteNames.mainScreen);
    }
  }
}
