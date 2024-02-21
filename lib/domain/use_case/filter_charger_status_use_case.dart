import 'package:ev_charger_app/domain/model/charger_model.dart';

class FilterChargerStatusUseCase {
  List<ChargerModel> execute(
      List<ChargerModel> inputChargers, List<int> statusFilters) {
    return inputChargers
        .where((charger) => statusFilters.contains(charger.status))
        .toList();
  }
}
