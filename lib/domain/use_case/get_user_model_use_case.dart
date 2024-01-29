import 'package:ev_charger_app/domain/model/user_model.dart';
import 'package:ev_charger_app/domain/repository/auth_repository.dart';
import 'package:ev_charger_app/domain/repository/kakao_auth_repository.dart';

// Todo: 지금은 kakao login만 사용 가능. jwt 사용시 변경 예정
class GetUserModelUseCase {
  final AuthRepository _authRepository;
  final KakaoAuthRepository _kakaoAuthRepository;
  UserModel? _userModel;

  GetUserModelUseCase({
    required AuthRepository authRepository,
    required KakaoAuthRepository kakaoAuthRepository,
  })  : _authRepository = authRepository,
        _kakaoAuthRepository = kakaoAuthRepository;

  Future<UserModel> execute({bool needRefreshCache = false}) async {
    if (_userModel == null) {
      final UserModel kakaoUserModel =
          await _kakaoAuthRepository.getUserModel();
      _userModel = await _authRepository.getUserModel(kakaoUserModel.id);
    }

    if (needRefreshCache) {
      _userModel = await _authRepository.getUserModel(_userModel!.id);
    }

    return _userModel!;
  }
}
