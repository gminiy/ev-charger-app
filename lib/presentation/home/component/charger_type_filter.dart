import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'charger_type_filter.freezed.dart';

part 'charger_type_filter.g.dart';

@freezed
class ChargerTypeFilter with _$ChargerTypeFilter {
  const factory ChargerTypeFilter({
    required String label,
    required int index,
    required bool isSelected,
  }) = _ChargerTypeFilter;

  factory ChargerTypeFilter.fromJson(Map<String, Object?> json) => _$ChargerTypeFilterFromJson(json);
}