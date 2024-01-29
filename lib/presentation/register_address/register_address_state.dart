import 'package:ev_charger_app/domain/model/address_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'register_address_state.freezed.dart';

part 'register_address_state.g.dart';

@freezed
class RegisterAddressState with _$RegisterAddressState {
  const factory RegisterAddressState({
    @Default(false) bool isLoading,
    @Default([]) List<AddressModel> addresses,
    AddressModel? selected,
  }) = _RegisterAddressState;

  factory RegisterAddressState.fromJson(Map<String, Object?> json) =>
      _$RegisterAddressStateFromJson(json);
}
