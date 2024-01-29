import 'package:ev_charger_app/domain/model/user_model.dart';
import 'package:ev_charger_app/domain/repository/auth_repository.dart';
import 'package:ev_charger_app/domain/use_case/get_user_model_use_case.dart';

class UpdateUserUseCase {
  final AuthRepository _authRepository;
  final GetUserModelUseCase _getUserModelUseCase;

  const UpdateUserUseCase({
    required AuthRepository authRepository,
    required GetUserModelUseCase getUserModelUseCase,
  })  : _authRepository = authRepository,
        _getUserModelUseCase = getUserModelUseCase;

  Future<UserModel> execute(UserModel newUser) async {
    await _authRepository.update(newUser);

    return await _getUserModelUseCase.execute(needRefreshCache: true);
  }
}
