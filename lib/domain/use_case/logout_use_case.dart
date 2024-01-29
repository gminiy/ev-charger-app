import 'package:ev_charger_app/domain/repository/kakao_auth_repository.dart';

class LogoutUseCase {
  final KakaoAuthRepository _kakaoAuthRepository;

  const LogoutUseCase({
    required KakaoAuthRepository kakaoAuthRepository,
  }) : _kakaoAuthRepository = kakaoAuthRepository;

  Future<void> execute() async {
    await _kakaoAuthRepository.logout();
  }
}