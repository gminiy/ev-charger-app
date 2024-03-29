import 'package:ev_charger_app/domain/use_case/kakao_login_use_case.dart';
import 'package:ev_charger_app/presentation/auth_status.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final KakaoLoginUseCase _kakaoLoginUseCase;
  final AuthStatus _authStatus;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  LoginViewModel({
    required KakaoLoginUseCase kakaoLoginUseCase,
    required AuthStatus authStatus,
  })  : _kakaoLoginUseCase = kakaoLoginUseCase,
        _authStatus = authStatus;

  Future<void> login() async {
    _isLoading = true;
    notifyListeners();

    await _kakaoLoginUseCase.execute();
    _authStatus.setIsLogin(true);
    notifyListeners();
  }
}
