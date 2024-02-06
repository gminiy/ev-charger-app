import 'package:ev_charger_app/domain/use_case/get_user_model_use_case.dart';
import 'package:ev_charger_app/domain/use_case/update_user_use_case.dart';
import 'package:ev_charger_app/presentation/profile/profile_state.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final GetUserModelUseCase _getUserModelUseCase;
  final UpdateUserUseCase _updateUserUseCase;
  ProfileState _state = const ProfileState();

  ProfileState get state => _state;

  ProfileViewModel({
    required GetUserModelUseCase getUserModelUseCase,
    required UpdateUserUseCase updateUserUseCase,
  })  : _getUserModelUseCase = getUserModelUseCase,
        _updateUserUseCase = updateUserUseCase {
    init();
  }

  Future<void> init() async {
    final userModel = await _getUserModelUseCase.execute();
    _state = state.copyWith(
      userModel: userModel,
    );
    notifyListeners();
  }

  Future<void> updateProfile(String nickname) async {
    if (state.userModel == null) {
      return;
    }

    final updatedUserModel = state.userModel!.copyWith(
      nickname: nickname,
    );

    await _updateUserUseCase.execute(updatedUserModel);
    final userModel = await _getUserModelUseCase.execute();
    _state = state.copyWith(
      userModel: userModel,
    );

    notifyListeners();
  }
}
