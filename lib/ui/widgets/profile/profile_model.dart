import 'package:flutter/cupertino.dart';
import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class ProfileModel extends ChangeNotifier {
  final _authService = AuthService();

  Future<void> logout(BuildContext context) async {
    await _authService.logout();
    MainNavigation.resetNavigation(context);
  }
}
