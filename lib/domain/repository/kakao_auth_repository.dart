import 'package:ev_charger_app/domain/model/user_model.dart';

abstract interface class KakaoAuthRepository {
  Future<bool> isLogin();
  Future<bool> isValidAccessToken();
  Future<UserModel> login();
  Future<void> logout();
  Future<UserModel> getUserModel();
}