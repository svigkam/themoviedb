import 'package:flutter/material.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _authService = AuthService();

  final loginTextController = TextEditingController(text: 'igkam');
  final passwordTextController = TextEditingController(text: 'svenigor');

  bool _isAuthProgress = false;
  bool get isAuthProgress => _isAuthProgress;
  bool get canStartAuth => !_isAuthProgress;

  bool _isValid(String login, String password) =>
      login.isNotEmpty && password.isNotEmpty;

  Future<void> _login(
    String login,
    String password,
    BuildContext context,
  ) async {
    try {
      await _authService.login(login, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          showSnackBar(
              context, 'Сервер не доступен. Проверьте подключение к интернету.',
              color: Colors.red);
          break;
        case ApiClientExceptionType.auth:
          showSnackBar(context, 'Неверный логин и пароль!', color: Colors.red);
          break;
        case ApiClientExceptionType.other:
          showSnackBar(context, 'Произошла ошибка. Попробуйте еще раз.',
              color: Colors.red);
          break;
        case ApiClientExceptionType.sessionExpired:
      }
    } catch (e) {
      showSnackBar(context, 'Неизвестная ошибка.', color: Colors.red);
    }
  }

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (!_isValid(login, password)) {
      showSnackBar(context, 'Заполните логин и пароль', color: Colors.red);
      notifyListeners();
      return;
    }

    _isAuthProgress = true;
    notifyListeners();
    await _login(login, password, context);

    _isAuthProgress = false;
    notifyListeners();
    MainNavigation.resetNavigation(context);
  }
}
