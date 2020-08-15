import 'package:flutter/foundation.dart';

class LoginRegistrationModel extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void goToRegister() {
    _currentPage = 0;
    notifyListeners();
  }

  void goToLogin() {
    _currentPage = 1;
    notifyListeners();
  }

  void goToWelcome() {
    _currentPage = 2;
    notifyListeners();
  }
}
