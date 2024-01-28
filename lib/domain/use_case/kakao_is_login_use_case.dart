import 'package:ev_charger_app/domain/repository/kakao_auth_repository.dart';

class IsLoginUseCase {
  final KakaoAuthRepository _repository;

  const IsLoginUseCase({
    required KakaoAuthRepository repository,
  }) : _repository = repository;

  Future<bool> execute() async {
    return await _repository.isLogin();
  }
}
