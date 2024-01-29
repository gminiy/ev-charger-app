import 'package:ev_charger_app/domain/repository/kakao_auth_repository.dart';

class KakaoIsLoginUseCase {
  final KakaoAuthRepository _kakaoAuthRepository;

  const KakaoIsLoginUseCase({
    required KakaoAuthRepository kakaoAuthRepository,
  }) : _kakaoAuthRepository = kakaoAuthRepository;

  Future<bool> execute() async {
    return await _kakaoAuthRepository.isLogin();
  }
}
