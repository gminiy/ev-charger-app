import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'charger_status_filter.freezed.dart';

part 'charger_status_filter.g.dart';

@freezed
class ChargerStatusFilter with _$ChargerStatusFilter {
  const factory ChargerStatusFilter({
    required String label,
    required int index,
    required bool isSelected,
  }) = _ChargerStatusFilter;

  factory ChargerStatusFilter.fromJson(Map<String, Object?> json) =>
      _$ChargerStatusFilterFromJson(json);
}
