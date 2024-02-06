import 'package:ev_charger_app/domain/model/charger_model.dart';
import 'package:ev_charger_app/domain/use_case/filter_charger_status_use_case.dart';
import 'package:ev_charger_app/domain/use_case/filter_charger_type_use_case.dart';
import 'package:ev_charger_app/domain/use_case/get_chargers_use_case.dart';
import 'package:ev_charger_app/domain/use_case/get_user_model_use_case.dart';
import 'package:ev_charger_app/domain/use_case/logout_use_case.dart';
import 'package:ev_charger_app/presentation/home/component/charger_status_filter.dart';
import 'package:ev_charger_app/presentation/home/component/charger_type_filter.dart';
import 'package:ev_charger_app/presentation/home/home_state.dart';
import 'package:ev_charger_app/domain/util/charger_status_map.dart';
import 'package:ev_charger_app/domain/util/charger_type_map.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeState _state = const HomeState();
  final GetUserModelUseCase _getUserModelUseCase;
  final GetChargersUseCase _getChargersUseCase;
  final LogoutUseCase _logoutUseCase;
  final FilterChargerStatusUseCase _filterChargerStatusUseCase;
  final FilterChargerTypeUseCase _filterChargerTypeUseCase;

  HomeState get state => _state;

  HomeViewModel({
    required GetUserModelUseCase getUserModelUseCase,
    required GetChargersUseCase getChargersUseCase,
    required LogoutUseCase logoutUseCase,
    required FilterChargerStatusUseCase filterChargerStatusUseCase,
    required FilterChargerTypeUseCase filterChargerTypeUseCase,
  })  : _getUserModelUseCase = getUserModelUseCase,
        _getChargersUseCase = getChargersUseCase,
        _logoutUseCase = logoutUseCase,
        _filterChargerStatusUseCase = filterChargerStatusUseCase,
        _filterChargerTypeUseCase = filterChargerTypeUseCase {
    init();
  }

  Future<void> _fetchChargerModels() async {
    if (state.userModel == null) {
      return;
    }

    List<ChargerModel> chargers = await _getChargersUseCase
        .execute(state.userModel!.addressId ?? 'undefined');

    final List<int> statusFilterIndexes = state.statusFilters
        .where((e) => e.isSelected)
        .map((e) => e.index)
        .toList();

    chargers =
        _filterChargerStatusUseCase.execute(chargers, statusFilterIndexes);

    final List<int> typeFilterIndexes = state.typeFilters
        .where((e) => e.isSelected)
        .map((e) => e.index)
        .toList();
    chargers = _filterChargerTypeUseCase.execute(chargers, typeFilterIndexes);

    _state = state.copyWith(chargerModels: chargers);
  }

  Future<void> init() async {
    final user = await _getUserModelUseCase.execute();
    final List<ChargerStatusFilter> defaultStatusFilters = chargerStatusMap.keys
        .map(
          (e) => ChargerStatusFilter(
              label: chargerStatusMap[e]!['label'] as String,
              index: chargerStatusMap[e]!['index'] as int,
              isSelected: true),
        )
        .toList();
    final List<ChargerTypeFilter> defaultTypeFilters = chargerTypeMap.keys
        .map(
          (e) => ChargerTypeFilter(
              label: chargerStatusMap[e]!['label'] as String,
              index: chargerStatusMap[e]!['index'] as int,
              isSelected: true),
        )
        .toList();

    _state = state.copyWith(
      userModel: user,
      statusFilters: defaultStatusFilters,
      typeFilters: defaultTypeFilters,
    );

    await _fetchChargerModels();

    notifyListeners();
  }

  Future<void> logout() async {
    await _logoutUseCase.execute();
  }

  void toggleStatusFilter() {
    _state = state.copyWith(
      isToggledTypeFilter: false,
      isToggledOutputFilter: false,
      isToggledStatusFilter: !state.isToggledStatusFilter,
    );
    notifyListeners();
  }

  void toggleTypeFilter() {
    _state = state.copyWith(
      isToggledStatusFilter: false,
      isToggledOutputFilter: false,
      isToggledTypeFilter: !state.isToggledTypeFilter,
    );
    notifyListeners();
  }

  void toggleOutputFilter() {
    _state = state.copyWith(
      isToggledStatusFilter: false,
      isToggledTypeFilter: false,
      isToggledOutputFilter: !state.isToggledOutputFilter,
    );
    notifyListeners();
  }

  Future<void> handleStatusFilter(ChargerStatusFilter statusFilter) async {
    final updatedStatusFilters = state.statusFilters
        .map((e) => e.index == statusFilter.index
            ? statusFilter.copyWith(isSelected: !e.isSelected)
            : e)
        .toList();

    _state = state.copyWith(statusFilters: updatedStatusFilters);
    await _fetchChargerModels();

    notifyListeners();
  }

  Future<void> handleTypeFilter(ChargerTypeFilter typeFilter) async {
    final updatedTypeFilters = state.typeFilters
        .map((e) => e.index == typeFilter.index
            ? typeFilter.copyWith(isSelected: !e.isSelected)
            : e)
        .toList();

    _state = state.copyWith(typeFilters: updatedTypeFilters);
    await _fetchChargerModels();

    notifyListeners();
  }
}
