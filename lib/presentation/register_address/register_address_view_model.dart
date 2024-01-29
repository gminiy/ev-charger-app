import 'package:ev_charger_app/core/debounce.dart';
import 'package:ev_charger_app/domain/use_case/find_addresses_use_case.dart';
import 'package:ev_charger_app/presentation/register_address/register_address_state.dart';
import 'package:flutter/material.dart';

class RegisterAddressViewModel extends ChangeNotifier {
  final FindAddressesUseCase _findAddressesUseCase;
  final _debounce = Debounce(const Duration(milliseconds: 500));
  RegisterAddressState _state = const RegisterAddressState();

  RegisterAddressState get state => _state;

  RegisterAddressViewModel({
    required FindAddressesUseCase findAddressesUseCase,
  }) : _findAddressesUseCase = findAddressesUseCase;

  Future<void> fetchAddresses(String pattern) async {
    print(pattern);
    if (pattern == '') {
      _state = state.copyWith(isLoading: false, addresses: []);
      notifyListeners();
      return;
    }

    _debounce.onEvent(() async {
      _state = state.copyWith(isLoading: true);
      notifyListeners();

      final addresses = await _findAddressesUseCase.execute(pattern);
      _state = state.copyWith(isLoading: false, addresses: addresses);
      notifyListeners();
    });
  }
}
