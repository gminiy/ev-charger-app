import 'package:ev_charger_app/domain/model/user_model.dart';
import 'package:ev_charger_app/domain/repository/auth_repository.dart';
import 'package:ev_charger_app/domain/use_case/kakao_login_use_case.dart';

// Todo: 지금은 kakao login만 사용 가능. jwt 사용시 변경 예정
class GetUserModelUseCase {
  final AuthRepository _repository;
  final KakaoLoginUseCase _kakaoLoginUseCase;
  UserModel? _userModel;

  GetUserModelUseCase({
    required AuthRepository repository,
    required KakaoLoginUseCase kakaoLoginUseCase,
  })  : _repository = repository,
        _kakaoLoginUseCase = kakaoLoginUseCase;

  Future<UserModel> execute({bool needRefreshCache = false}) async {
    _userModel = _userModel ?? await _kakaoLoginUseCase.execute();

    if (needRefreshCache) {
      _userModel = await _repository.getUserModel(_userModel!.id);
    }

    return _userModel!;
  }
}
