import 'package:ev_charger_app/domain/model/charger_model.dart';

class FilterChargerTypeUseCase {
  List<ChargerModel> execute(
      List<ChargerModel> inputChargers, List<int> typeFilters) {
    return inputChargers
        .where((charger) => typeFilters.contains(charger.chargeType))
        .toList();
  }
}
