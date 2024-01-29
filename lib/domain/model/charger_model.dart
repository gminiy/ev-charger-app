import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'charger_model.freezed.dart';

part 'charger_model.g.dart';

@freezed
class ChargerModel with _$ChargerModel {
  const factory ChargerModel({
    required String id,
    required int chargeType,
    required String location,
    required int status,
    required int lastStatusUpdatedAt,
    required int output,
    int? lastStartChargingTimestamp,
    int? lastEndChargingTimestamp,
  }) = _ChargerModel;

  factory ChargerModel.fromJson(Map<String, Object?> json) => _$ChargerModelFromJson(json);
}