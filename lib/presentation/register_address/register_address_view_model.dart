import 'package:ev_charger_app/core/debounce.dart';
import 'package:ev_charger_app/domain/model/address_model.dart';
import 'package:ev_charger_app/domain/model/user_model.dart';
import 'package:ev_charger_app/domain/use_case/find_addresses_use_case.dart';
import 'package:ev_charger_app/domain/use_case/get_user_model_use_case.dart';
import 'package:ev_charger_app/domain/use_case/update_user_use_case.dart';
import 'package:ev_charger_app/presentation/register_address/register_address_state.dart';
import 'package:flutter/material.dart';

class RegisterAddressViewModel extends ChangeNotifier {
  final FindAddressesUseCase _findAddressesUseCase;
  final UpdateUserUseCase _updateUserUseCase;
  final GetUserModelUseCase _getUserModelUseCase;
  final _debounce = Debounce(const Duration(milliseconds: 500));
  RegisterAddressState _state = const RegisterAddressState();

  RegisterAddressState get state => _state;

  RegisterAddressViewModel({
    required FindAddressesUseCase findAddressesUseCase,
    required UpdateUserUseCase updateUserUseCase,
    required GetUserModelUseCase getUserModelUseCase,
  })  : _findAddressesUseCase = findAddressesUseCase,
        _updateUserUseCase = updateUserUseCase,
        _getUserModelUseCase = getUserModelUseCase;

  Future<void> fetchAddresses(String pattern) async {
    _state = state.copyWith(selected: null);
    notifyListeners();

    if (pattern == '') {
      _state = state.copyWith(isLoading: false, addresses: []);
      notifyListeners();
      _debounce.cancel();
      return;
    }

    _debounce.onEvent(() async {
      _state = state.copyWith(isLoading: true);
      notifyListeners();

      final addresses = await _findAddressesUseCase.execute(pattern);
      _state = state.copyWith(
          isLoading: false, addresses: addresses, selected: null);
      notifyListeners();
    });
  }

  selectAddress(AddressModel address) async {
    _state = state.copyWith(selected: address);
    notifyListeners();
  }

  Future<void> registerAddress(AddressModel address) async {
    final UserModel user = await _getUserModelUseCase.execute();
    final UserModel newUser = user.copyWith(addressId: address.id);
    await _updateUserUseCase.execute(newUser);
  }
}
