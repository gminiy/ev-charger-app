import 'package:ev_charger_app/data/data_source/remote/server_api.dart';
import 'package:ev_charger_app/domain/model/charger_model.dart';
import 'package:ev_charger_app/domain/repository/charger_repository.dart';

class ChargerRepositoryImpl implements ChargerRepository {
  final ServerApi _api;

  const ChargerRepositoryImpl({
    required ServerApi api,
  }) : _api = api;

  @override
  Future<List<ChargerModel>> getChargers(String addressId) async {
    final response = await _api.getChargers(addressId);

    return response
        .map(
          (e) => ChargerModel(
            id: e['id'],
            addressId: e['addressId'],
            chargeType: e['chargeType'],
            location: e['location'],
            status: e['status'],
            lastStatusUpdatedAt: e['lastStatusUpdatedAt'],
            output: e['output'],
            lastStartChargingTimestamp: e['lastStartChargingTimestamp'],
            lastEndChargingTimestamp: e['lastEndChargingTimestamp'],
          ),
        )
        .toList();
  }
}
