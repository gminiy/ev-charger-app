import 'package:ev_charger_app/domain/model/address_model.dart';

abstract interface class AddressRepository {
  Future<List<AddressModel>> findAddresses(String? pattern);
}