import 'package:flutter/cupertino.dart';

class AuthStatus extends ChangeNotifier {
  bool _isLogin = false;
  String? _addressId;

  bool get isLogin => _isLogin;

  String? get addressId => _addressId;

  setIsLogin(bool isLogin) {
    _isLogin = isLogin;
    notifyListeners();
  }

  setAddressId(String? addressId) {
    _addressId = addressId;
    notifyListeners();
  }
}
