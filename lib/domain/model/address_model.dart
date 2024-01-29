import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'address_model.freezed.dart';

part 'address_model.g.dart';

@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    required String id,
    required String address,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, Object?> json) => _$AddressModelFromJson(json);
}