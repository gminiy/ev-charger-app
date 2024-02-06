import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'charger_output_filter.freezed.dart';

part 'charger_output_filter.g.dart';

@freezed
class ChargerOutputFilter with _$ChargerOutputFilter {
  const factory ChargerOutputFilter({
    required int minOutput,
    required int maxOutput,
    required bool isSelected,
  }) = _ChargerOutputFilter;

  factory ChargerOutputFilter.fromJson(Map<String, Object?> json) => _$ChargerOutputFilterFromJson(json);
}