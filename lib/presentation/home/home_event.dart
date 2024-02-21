import 'package:ev_charger_app/presentation/home/component/charger_status_filter.dart';
import 'package:ev_charger_app/presentation/home/component/charger_type_filter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'home_event.freezed.dart';

@freezed
sealed class HomeEvent<T> with _$HomeEvent<T> {
  const factory HomeEvent.toggleStatusFilter() = ToggleStatusFilter;
  const factory HomeEvent.toggleTypeFilter() = ToggleTypeFilter;
  const factory HomeEvent.toggleOutputFilter() = ToggleOutputFilter;
  const factory HomeEvent.handleOutputFilter(int minOutput, int maxOutput) = HandleOutputFilter;
  const factory HomeEvent.handleStatusFilter(ChargerStatusFilter statusFilter) = HandleStatusFilter;
  const factory HomeEvent.handleTypeFilter(ChargerTypeFilter typeFilter) = HandleTypeFilter;
  const factory HomeEvent.logout() = Logout;
}