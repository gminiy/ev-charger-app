import 'package:ev_charger_app/domain/model/charger_model.dart';

abstract interface class ChargerRepository {
  Future<List<ChargerModel>>getChargers(String addressId);
}