import 'package:ev_charger_app/domain/model/address_model.dart';
import 'package:ev_charger_app/domain/repository/address_repository.dart';

class FindAddressesUseCase {
  final AddressRepository _addressRepository;

  const FindAddressesUseCase({
    required AddressRepository addressRepository,
  }) : _addressRepository = addressRepository;

  Future<List<AddressModel>> execute(String? pattern) async =>
      await _addressRepository.findAddresses(pattern);
}
