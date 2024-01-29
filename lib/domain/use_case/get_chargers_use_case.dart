import 'package:ev_charger_app/domain/model/charger_model.dart';
import 'package:ev_charger_app/domain/repository/charger_repository.dart';

class GetChargersUseCase {
  final ChargerRepository _repository;

  const GetChargersUseCase({
    required ChargerRepository repository,
  }) : _repository = repository;

  Future<List<ChargerModel>> execute(String addressId) async =>
      await _repository.getChargers(addressId);
}
