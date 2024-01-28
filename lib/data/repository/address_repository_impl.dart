import 'package:ev_charger_app/data/data_source/remote/server_api.dart';
import 'package:ev_charger_app/domain/model/address_model.dart';
import 'package:ev_charger_app/domain/repository/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final ServerAPi _api;

  const AddressRepositoryImpl({
    required ServerAPi api,
  }) : _api = api;

  @override
  Future<List<AddressModel>> findAddresses(String? pattern) async {
    final response = await _api.findAddresses(pattern);

    return response
        .map(
          (e) => AddressModel(
            id: e['id'],
            address: e['address'],
          ),
        )
        .toList();
  }
}
