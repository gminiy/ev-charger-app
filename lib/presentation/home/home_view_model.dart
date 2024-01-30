import 'package:ev_charger_app/domain/use_case/get_chargers_use_case.dart';
import 'package:ev_charger_app/domain/use_case/get_user_model_use_case.dart';
import 'package:ev_charger_app/domain/use_case/logout_use_case.dart';
import 'package:ev_charger_app/presentation/home/home_state.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeState _state = const HomeState();
  final GetUserModelUseCase _getUserModelUseCase;
  final GetChargersUseCase _getChargersUseCase;
  final LogoutUseCase _logoutUseCase;

  HomeState get state => _state;

  HomeViewModel({
    required GetUserModelUseCase getUserModelUseCase,
    required GetChargersUseCase getChargersUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _getUserModelUseCase = getUserModelUseCase,
        _getChargersUseCase = getChargersUseCase,
        _logoutUseCase = logoutUseCase {
    init();
  }

  Future<void> init() async {
    final user = await _getUserModelUseCase.execute();
    _state = _state.copyWith(userModel: user);
    final chargers =
        await _getChargersUseCase.execute(user.addressId ?? 'undefined');
    _state = state.copyWith(chargerModels: chargers);
    notifyListeners();
  }

  Future<void> logout() async {
    await _logoutUseCase.execute();
  }
}
