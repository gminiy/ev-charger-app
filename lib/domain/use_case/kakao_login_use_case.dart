import 'package:ev_charger_app/domain/model/user_model.dart';
import 'package:ev_charger_app/domain/repository/auth_repository.dart';
import 'package:ev_charger_app/domain/repository/kakao_auth_repository.dart';

class KakaoLoginUseCase {
  final KakaoAuthRepository _kakaoAuthRepository;
  final AuthRepository _authRepository;

  const KakaoLoginUseCase({
    required KakaoAuthRepository kakaoAuthRepository,
    required AuthRepository authRepository,
  })  : _kakaoAuthRepository = kakaoAuthRepository,
        _authRepository = authRepository;

  Future<UserModel> execute() async {
    final UserModel userModelKakao = await _kakaoAuthRepository.login();
    final UserModel userModel = await _authRepository.login(userModelKakao);

    return userModel;
  }
}
