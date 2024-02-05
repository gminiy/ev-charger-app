import 'package:ev_charger_app/domain/model/user_model.dart';
import 'package:ev_charger_app/domain/use_case/get_user_model_use_case.dart';
import 'package:ev_charger_app/domain/use_case/logout_use_case.dart';
import 'package:flutter/material.dart';

class DrawerViewModel extends ChangeNotifier {
  final GetUserModelUseCase _getUserModelUseCase;
  final LogoutUseCase _logoutUseCase;
  UserModel? _user;

  UserModel? get user => _user;

  DrawerViewModel({
    required GetUserModelUseCase getUserModelUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _getUserModelUseCase = getUserModelUseCase,
        _logoutUseCase = logoutUseCase {
    init();
  }

  Future<void> init() async {
    _user = await _getUserModelUseCase.execute();
    notifyListeners();
  }

  Future<void> logout() async {
    await _logoutUseCase.execute();
  }
}
