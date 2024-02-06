import 'package:ev_charger_app/domain/model/charger_model.dart';
import 'package:ev_charger_app/domain/model/user_model.dart';
import 'package:ev_charger_app/presentation/home/component/charger_status_filter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'home_state.freezed.dart';

part 'home_state.g.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    UserModel? userModel,
    @Default([]) List<ChargerModel> chargerModels,
    @Default([]) List<ChargerStatusFilter> statusFilters,
    @Default(false) bool isToggledStatusFilter,
    @Default(false) bool isToggledTypeFilter,
    @Default(false) bool isToggledOutputFilter,
  }) = _HomeState;

  factory HomeState.fromJson(Map<String, Object?> json) =>
      _$HomeStateFromJson(json);
}
