import 'package:flutter/cupertino.dart';

class AuthStatus extends ChangeNotifier {
  bool _isLogin = false;
  bool _isRegisteredAddress = false;

  bool get isLogin => _isLogin;

  bool get isRegisteredAddress => _isRegisteredAddress;

  setIsLogin(bool isLogin) {
    _isLogin = isLogin;
    notifyListeners();
  }

  setIsRegisteredAddress(bool isRegisteredAddress) {
    _isRegisteredAddress = isRegisteredAddress;
    notifyListeners();
  }
}
