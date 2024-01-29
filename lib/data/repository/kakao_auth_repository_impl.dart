import 'package:ev_charger_app/data/data_source/remote/kakao_api.dart';
import 'package:ev_charger_app/data/mapper/kakao_user_mapper.dart';
import 'package:ev_charger_app/domain/model/user_model.dart';
import 'package:ev_charger_app/domain/repository/kakao_auth_repository.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoAuthRepositoryImpl implements KakaoAuthRepository {
  final KakaoApi _api;

  const KakaoAuthRepositoryImpl({
    required KakaoApi api,
  }) : _api = api;

  @override
  Future<bool> isLogin() async {
    return await _api.isLogin();
  }

  @override
  Future<bool> isValidAccessToken() async {
    return await _api.isValidAccessToken();
  }

  @override
  Future<UserModel> login() async {
    final User user = await _api.login();

    return user.toUserModel();
  }

  @override
  Future<void> logout() async {
    await _api.logout();
  }

  @override
  Future<UserModel> getUserModel() async {
    final User user = await _api.getUser();

    return user.toUserModel();
  }
}
